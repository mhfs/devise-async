module Devise
  module Async
    module Backend
      class DelayedJob < Base
        def self.enqueue(*args)
          new.delay(:queue => Devise::Async.queue, :priority => priority).perform(*args)
        end

        def self.priority
          Devise::Async.priority.nil? ? Delayed::Worker.default_priority : Devise::Async.priority
        end
      end
    end
  end
end
