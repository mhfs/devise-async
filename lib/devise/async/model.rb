module Devise
  module Models
    module Async
      extend ActiveSupport::Concern

      included do
        if respond_to?(:after_commit) # AR only
          after_commit :send_devise_pending_notifications
        else # mongoid
          after_save :send_devise_pending_notifications
        end
      end

      protected

      def send_devise_notification(notification)
        if changed?
          devise_pending_notifications << notification
        else
          Devise::Async::Worker.enqueue(notification, self.class.name, self.id.to_s)
        end
      end

      def send_devise_pending_notifications
        devise_pending_notifications.each do |notification|
          # Use `id.to_s` to avoid problems with mongoid 2.4.X ids being serialized
          # wrong with YAJL.
          Devise::Async::Worker.enqueue(notification, self.class.name, self.id.to_s)
        end
        @devise_pending_notifications = []
      end

      def devise_pending_notifications
        @devise_pending_notifications ||= []
      end
    end
  end
end
