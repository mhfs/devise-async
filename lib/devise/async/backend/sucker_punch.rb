module Devise
  module Async
    module Backend
      class SuckerPunch < Base
        include ::SuckerPunch::Job

        def self.enqueue(*args)
          perform(*args)
        end

        def self.perform(*args)
          new.async.perform(*args)
        end

        def perform(*args)
          if active_record_adapter? args.second
            ActiveRecord::Base.connection_pool.with_connection{ super }
          else
            super
          end
        end

        private

        def active_record_adapter?(resource_class)
          resource_class.constantize.to_adapter.class.name == "OrmAdapter::ActiveRecord"
        end
      end
    end
  end
end
