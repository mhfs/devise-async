module Devise
  module Models
    module Async
      extend ActiveSupport::Concern

      included do
        # Register hook to send all devise pending notifications.
        #
        # When supported by the ORM/database we send just after commit to
        # prevent the backend of trying to fetch the record and send the
        # notification before the record is committed to the databse.
        #
        # Otherwise we use after_save.
        if respond_to?(:after_commit) # AR only
          after_commit :send_devise_pending_notifications
        else # mongoid
          after_save :send_devise_pending_notifications
        end
      end

      protected

      # This method overwrites devise's own `send_devise_notification`
      # to capture all email notifications and enqueue it for background
      # processing instead of sending it inline as devise does by
      # default.
      def send_devise_notification(notification, *args)
        return super unless Devise::Async.enabled

        # If the record is dirty we keep pending notifications to be enqueued
        # by the callback and avoid before commit job processing.
        if changed?
          devise_pending_notifications << [ notification, args ]
        # If the record isn't dirty (aka has already been saved) enqueue right away
        # because the callback has already been triggered.
        else
          Devise::Async::Worker.enqueue(notification, self.class.name, self.id.to_s, *args)
        end
      end

      # Send all pending notifications.
      def send_devise_pending_notifications
        devise_pending_notifications.each do |notification, args|
          # Use `id.to_s` to avoid problems with mongoid 2.4.X ids being serialized
          # wrong with YAJL.
          Devise::Async::Worker.enqueue(notification, self.class.name, self.id.to_s, *args)
        end
        @devise_pending_notifications = []
      end

      def devise_pending_notifications
        @devise_pending_notifications ||= []
      end
    end
  end
end
