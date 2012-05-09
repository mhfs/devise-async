module DeviseAsync
  class Proxy

    # catches all devise emails
    def self.method_missing(method, *args, &block)
      new(method, args.first)
    end

    def initialize(method, resource)
      @method, @resource = method, resource
    end

    def deliver
      worker.enqueue(@method, @resource.class.name, @resource.id)
    end

    private

    def worker
      Worker
    end
  end
end
