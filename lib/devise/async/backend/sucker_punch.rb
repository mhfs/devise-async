require "sucker_punch"

module Devise
  module Async
    module Backend
      class SuckerPunch < Base
        include ::SuckerPunch::Job

        def self.enqueue(*args)
          new.async.perform(*args)
        end

        # Return the connection to the pool after we're done with it
        # see: https://github.com/brandonhilkert/sucker_punch#usage
        def perform(method, resource_class, resource_id, *args)
          ActiveRecord::Base.connection_pool.with_connection do
            super
          end
        end
      end
    end
  end
end