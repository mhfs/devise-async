require "queue_classic"

module Devise
  module Async
    module Backend
      class QueueClassic < Base
        def self.enqueue(method, *args)
          queue = ::QC::Queue.new(Devise::Async.queue)
          method = String(method) # QC won't serialize Symbol such as #{method}
          args.unshift("#{self}.perform", method)
          queue.enqueue(*args)
        end

        def self.perform(method, resource_class, resource_id, opts)
          new.perform(method, resource_class, resource_id, opts)
        end
      end
    end
  end
end
