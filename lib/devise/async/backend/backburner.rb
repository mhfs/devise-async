module Devise
  module Async
    module Backend
      class Backburner < Base

        def self.enqueue(*args)
          args.unshift(self)
          ::Backburner.enqueue(*args)
        end

        def self.perform(*args)
          new.perform(*args)
        end

        def self.queue
          Devise::Async.queue
        end

        def self.queue_priority
          Devise::Async.priority.nil? ? ::Backburner.configuration.default_priority : Devise::Async.priority
        end
      end
    end
  end
end
