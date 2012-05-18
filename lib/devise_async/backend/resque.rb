module DeviseAsync
  module Backend
    class Resque < Base
      @queue = :mailer

      def self.enqueue(*args)
        args.unshift(self)
        ::Resque.enqueue(*args)
      end

      def self.perform(method, resource_class, resource_id)
        new.perform(method, resource_class, resource_id)
      end
    end
  end
end
