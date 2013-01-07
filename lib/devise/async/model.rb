module Devise
  # TODO remove when appropriate
  module Async
    module Model
      extend ActiveSupport::Concern

      included do
        warn "Including Devise::Async::Model directly in your models is no longer supported and won't work. Please add `:async` to your `devise` call."
      end
    end
  end

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
      def send_devise_notification(notification)
        # If the record is dirty we keep pending notifications to be enqueued
        # by the callback and avoid before commit job processing.
        if changed?
          devise_pending_notifications << notification
        # If the record isn't dirty (aka has already been saved) enqueue right away
        # because the callback has already been triggered.
        else
          Devise::Async::Worker.enqueue(notification, self.class.name, self.id.to_s, mail_options(notification))
        end
      end

      # Send all pending notifications.
      def send_devise_pending_notifications
        devise_pending_notifications.each do |notification|
          # Use `id.to_s` to avoid problems with mongoid 2.4.X ids being serialized
          # wrong with YAJL.
          Devise::Async::Worker.enqueue(notification, self.class.name, self.id.to_s, mail_options(notification))
        end
        @devise_pending_notifications = []
      end

      def devise_pending_notifications
        @devise_pending_notifications ||= []
      end

      def mail_options(notification)
        # Can be overridden to allow extra options to be passed through when
        # sending that are not on the model. Each model implementing :async
        # can implement as necessary or leave to the default one. Returning
        # nil ensures options are not used. However if they are used a custom
        # mailer is required that accepts method calls of the form:
        #
        # def reset_password_instructions(record, options)
        #   ...
        # end
        #
        # By default, the devise mailer only takes record.
        nil
      end
    end
  end
end
