module Devise
  module Async
    module Backend
      class DelayedJob < Base
        def self.enqueue(*args)
          new.delay.perform(*args)
        end
      end
    end
  end
end
