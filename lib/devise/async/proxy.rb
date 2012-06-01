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
        # Use `id.to_s` to avoid problems with mongoid 2.4.X ids being serialized
        # wrong with YAJL.
        Worker.enqueue(@method, @resource.class.name, @resource.id.to_s)
      end
    end
  end
end
