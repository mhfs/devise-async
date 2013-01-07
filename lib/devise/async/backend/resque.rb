module Devise
  module Async
    module Backend
      class Resque < Base
        @queue = Devise::Async.queue

        def self.enqueue(*args)
          args.unshift(self)
          ::Resque.enqueue(*args)
        end

        def self.perform(method, resource_class, resource_id, options)
          new.perform(method, resource_class, resource_id, options)
        end
      end
    end
  end
end
