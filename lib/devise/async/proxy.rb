module Devise
  module Async
    # TODO remove when appropriate
    class Proxy
      # Catches all devise emails
      def self.method_missing(method, *args, &block)
        new(method, args.first)
      end

      def initialize(method, resource)
        puts "DEPRECATION WARNING: Devise::Async::Proxy is deprecated and Devise < 2.1.1 will be no longer supported by DeviseAsync when 1.0.0 is released. Please open a ticket and let me know if you have a reason to keep using it this way."
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
