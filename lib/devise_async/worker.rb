module DeviseAsync
  class Worker
    def self.enqueue(method, resource_class, resource_id)
      backend_class.enqueue(method, resource_class, resource_id)
    end

    private

    def self.backend_class
      Backend.for(DeviseAsync.backend)
    end
  end
end
