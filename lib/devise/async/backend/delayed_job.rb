module Devise
  module Async
    module Backend
      class DelayedJob < Base
        def self.enqueue(*args)
          new.delay(:queue => Devise::Async.queue, priority: Devise::Async.delayed_job_priority).perform(*args)
        end
      end
    end
  end
end
