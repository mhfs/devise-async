module Devise
  module Async
    module Backend
      class Base
        def self.enqueue(*args)
          raise NotImplementedError, "Any DeviseAssync::Backend subclass should implement `self.enqueue`."
        end

        def perform(method, resource_class, resource_id)
          resource = resource_class.constantize.find(resource_id)
          mailer_class.send(method, resource).deliver
        end

        private

        def mailer_class
          @mailer_class ||= Devise::Async.mailer.constantize
        end
      end
    end
  end
end
