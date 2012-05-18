module DeviseAsync
  module Backend
    class Base
      def self.enqueue(*args)
        raise NotImplementedError, "Any DeviseAssync::Backend subclass should implement `self.enqueue`."
      end

      def perform(method, resource_class, resource_id)
        resource = resource_class.constantize.find(resource_id)
        Devise::Mailer.send(method, resource).deliver
      end
    end
  end
end
