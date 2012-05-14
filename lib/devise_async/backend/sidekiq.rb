module DeviseAsync
  module Backend
    class Sidekiq
      include ::Sidekiq::Worker

      sidekiq_options :queue => :mailer

      def self.enqueue(*args)
        perform_async(*args)
      end

      def perform(method, resource_class, resource_id)
        resource = resource_class.constantize.find(resource_id)
        Devise::Mailer.send(method, resource).deliver
      end
    end
  end
end
