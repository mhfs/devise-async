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
        #
        # This method is executed within the scope of the locale of
        # the calling thread.
        def perform(method, resource_class, resource_id, *args)
          I18n.with_locale locale_from_args(args) do
            resource = resource_class.constantize.to_adapter.get!(resource_id)
            args[-1] = args.last.symbolize_keys if args.last.is_a?(Hash)
            mailer_class(resource).send(method, resource, *args).deliver
          end
        end

        private

        def mailer_class(resource = nil)
          @mailer_class ||= resource.try(:devise_mailer) || Devise.mailer
        end

        def locale_from_args(args)
          args_last = args.last
          args_last.delete('locale') if args_last.is_a?(Hash)
        end
      end
    end
  end
end
