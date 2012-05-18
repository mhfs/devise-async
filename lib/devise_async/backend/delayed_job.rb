module DeviseAsync
  module Backend
    class DelayedJob < Base
      def self.enqueue(*args)
        new.delay.perform(*args)
      end
    end
  end
end
