module DeviseBackground
  class Worker
    @queue = :mailer

    def self.enqueue(method, resource_class, resource_id)
      Resque.enqueue(self, method, resource_class, resource_id)
    end

    def self.perform(method, resource_class, resource_id)
      resource = resource_class.constantize.find(resource_id)
      Devise::Mailer.send(method, resource).deliver
    end
  end
end
