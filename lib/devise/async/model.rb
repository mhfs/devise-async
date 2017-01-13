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

        if new_record? || changed?
          devise_pending_notifications << [notification, args]
        else
          deliver_mail_later(notification, self, args)
        end
      end

      # Send all pending notifications.
      def send_devise_pending_notifications
        devise_pending_notifications.each do |notification, args|
          deliver_mail_later(notification, self, args)
        end

        @devise_pending_notifications.clear
      end

      def devise_pending_notifications
        @devise_pending_notifications ||= []
      end

      private

      def deliver_mail_later(notification, model, args)
        devise_mailer.send(notification, model, *args).deliver_later
      end
    end
  end
end
