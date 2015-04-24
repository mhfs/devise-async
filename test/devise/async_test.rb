require "test_helper"

module Devise
  describe "Async" do
    it "yields self when setup is called" do
      Async.setup { |config| config.must_equal Async }
    end

    it "stores backend config" do
      Async.backend = :something
      Async.backend.must_equal :something
    end

    it "stores enabled config" do
      Async.backend = false
      Async.backend.must_equal false
    end

    it "stores delayed_job_priority config" do
      Async.delayed_job_priority = -1
      Async.delayed_job_priority.must_equal -1
    end

    after do
      Async.backend = :resque
    end
  end
end
