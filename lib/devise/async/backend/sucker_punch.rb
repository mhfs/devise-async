require "sucker_punch"

module Devise
  module Async
    module Backend
      class SuckerPunch < Base
        include ::SuckerPunch::Job

        def self.enqueue(*args)
          new.async.perform(*args)
        end

        # Loads the resource record and sends the email.
        #
        # It uses `orm_adapter` API to fetch the record in order to enforce
        # compatibility among diferent ORMs.
        def perform(method, resource_class, resource_id, *args)
          ActiveRecord::Base.connection_pool.with_connection do
            resource = resource_class.constantize.to_adapter.get!(resource_id)
            args[-1] = args.last.symbolize_keys if args.last.is_a?(Hash)
            mailer_class(resource).send(method, resource, *args).deliver
          end
        end

        private

        def mailer_class(resource = nil)
          @mailer_class ||= Devise.mailer
        end
      end
    end
  end
end