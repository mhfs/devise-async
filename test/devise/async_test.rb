require "test_helper"

module Devise
  describe "Async" do

    after do
      Async.backend = :resque
    end

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

    it "stores priority config" do
      Async.priority = 15
      Async.priority.must_equal 15
      Async.priority = nil
    end

  end
end
