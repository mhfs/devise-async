module DeviseAsync
  module Backend
    class Resque
      @queue = :mailer

      def self.enqueue(*args)
        args.unshift(self)
        ::Resque.enqueue(*args)
      end

      def self.perform(method, resource_class, resource_id)
        resource = resource_class.constantize.find(resource_id)
        Devise::Mailer.send(method, resource).deliver
      end
    end
  end
end
