module Devise
  module Async
    class Proxy
      # Catches all devise emails
      def self.method_missing(method, *args, &block)
        new(method, args.first, args.second)
      end

      def initialize(method, resource, opts)
        @method, @resource, @opts = method, resource, opts
      end

      def deliver
        # Use `id.to_s` to avoid problems with mongoid 2.4.X ids being serialized
        # wrong with YAJL.
        Worker.enqueue(@method, @resource.class.name, @resource.id.to_s, @opts)
      end
    end
  end
end
