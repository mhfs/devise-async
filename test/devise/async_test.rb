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

    after do
      Async.backend = :resque
    end
  end
end
