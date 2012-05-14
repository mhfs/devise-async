require "test_helper"

module DeviseAsync
  describe "Worker" do
    it "enqueues job using the resque backend" do
      DeviseAsync.backend = :resque

      Backend::Resque.expects(:enqueue).with(:mailer_method, "User", 123)
      Worker.enqueue(:mailer_method, "User", 123)
    end

    it "enqueues job using the sidekiq backend" do
      DeviseAsync.backend = :sidekiq
      skip
    end

    it "enqueues job using the delayed job backend" do
      DeviseAsync.backend = :delayed_job
      skip
    end
  end
end
