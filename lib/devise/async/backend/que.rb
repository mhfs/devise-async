module Devise
  module Async
    module Backend
      class Que < Base
        class Job < ::Que::Job
          @queue = Devise::Async.queue

          def run(args)
            Backend::Que.new.perform(*args)
          end
        end

        def self.enqueue(*args)
          Job.enqueue(args)
        end
      end
    end
  end
end
