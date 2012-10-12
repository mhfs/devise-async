module Devise
  module Async
    module Backend
      class DelayedJob < Base
        def self.enqueue(*args)
          new.delay(:queue => Devise::Async.queue).perform(*args)
        end
      end
    end
  end
end
