module Devise
  module Async
    module Backend
      class Resque < Base
        @queue = Devise::Async.queue

        def self.enqueue(*args)
          args.unshift(self)
          ::Resque.enqueue(*args)
        end

        def self.perform(*args)
          new.perform(*args)
        end
      end
    end
  end
end
