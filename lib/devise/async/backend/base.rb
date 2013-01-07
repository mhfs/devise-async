module Devise
  module Async
    module Backend
      class Base
        def self.enqueue(*args)
          raise NotImplementedError, "Any DeviseAsync::Backend subclass should implement `self.enqueue`."
        end

        # Loads the resource record and sends the email.
        #
        # It uses `orm_adapter` API to fetch the record in order to enforce
        # compatibility among diferent ORMs.
        def perform(method, resource_class, resource_id, options)
          resource = resource_class.constantize.to_adapter.get!(resource_id)
          mail = nil
          if mailer_class.instance_method(method).arity == 1
            mail = mailer_class.send(method, resource).deliver
          else
            mail = mailer_class.send(method, resource, options).deliver
          end
          resource.devise_mail_sent(method) if Devise::Async.callback && resource.respond_to?(:devise_mail_sent)
          mail
        end

        private

        def mailer_class
          @mailer_class ||= Devise::Async.mailer.constantize
        end
      end
    end
  end
end
