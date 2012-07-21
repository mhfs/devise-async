module Devise
  module Async
    module Model
      extend ActiveSupport::Concern

      included do
        after_commit :send_devise_pending_notifications
      end

      protected

      def send_devise_notification(notification)
        devise_pending_notifications << notification
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
