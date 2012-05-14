module DeviseAsync
  module Backend
    class DelayedJob
      def self.enqueue(*args)
        new.delay.perform(*args)
      end

      def perform(method, resource_class, resource_id)
        resource = resource_class.constantize.find(resource_id)
        Devise::Mailer.send(method, resource).deliver
      end
    end
  end
end
