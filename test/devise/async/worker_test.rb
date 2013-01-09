require "test_helper"

module Devise
  module Async
    describe "Worker" do
      it "enqueues job using the resque backend" do
        Devise::Async.backend = :resque

        Backend::Resque.expects(:enqueue).with(:mailer_method, "User", 123, {})
        Worker.enqueue(:mailer_method, "User", 123, {})
      end

      it "enqueues job using the sidekiq backend" do
        Devise::Async.backend = :sidekiq

        Backend::Sidekiq.expects(:enqueue).with(:mailer_method, "User", 123, {})
        Worker.enqueue(:mailer_method, "User", 123, {})
      end

      it "enqueues job using the delayed job backend" do
        Devise::Async.backend = :delayed_job

        Backend::DelayedJob.expects(:enqueue).with(:mailer_method, "User", 123, {})
        Worker.enqueue(:mailer_method, "User", 123, {})
      end

      it "enqueues job using the queue classic backend" do
        Devise::Async.backend = :queue_classic

        Backend::QueueClassic.expects(:enqueue).with(:mailer_method, "User", 123, {})
        Worker.enqueue(:mailer_method, "User", 123, {})
      end
    end
  end
end
