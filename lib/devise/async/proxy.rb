module Devise
  module Async
    class Proxy
      # catches all devise emails
      def self.method_missing(method, *args, &block)
        new(method, args.first)
      end

      def initialize(method, resource)
        @method, @resource = method, resource
      end

      def deliver
        Worker.enqueue(@method, @resource.class.name, @resource.to_param)
      end
    end
  end
end
