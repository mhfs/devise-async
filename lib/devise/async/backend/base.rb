module Devise
  module Async
    module Backend
      class Base
        def self.enqueue(*args)
          raise NotImplementedError, "Any DeviseAssync::Backend subclass should implement `self.enqueue`."
        end

        # Loads the resource record and sends the email.
        #
        # It uses `orm_adapter` API to fetch the record in order to enforce
        # compatibility among diferent ORMs.
        def perform(method, resource_class, resource_id)
          resource = resource_class.constantize.to_adapter.get!(resource_id)
          mailer_class.send(method, resource).deliver
        end

        private

        def mailer_class
          # TODO switch to Devise.mailer when Devise::Async::Proxy is removed.
          @mailer_class ||= Devise::Async.mailer.constantize
        end
      end
    end
  end
end
