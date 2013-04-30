require "test_helper"

module Devise
  module Async
    describe "Backend" do
      it "gives resque as the backend" do
        Backend.for(:resque).must_equal Backend::Resque
      end

      it "gives sidekiq as the backend" do
        Backend.for(:sidekiq).must_equal Backend::Sidekiq
      end

      it "gives delayed job as the backend" do
        Backend.for(:delayed_job).must_equal Backend::DelayedJob
      end

      it "gives queue classic as the backend" do
        Backend.for(:queue_classic).must_equal Backend::QueueClassic
      end

      it "gives torquebox as the backend" do
        Backend.for(:torquebox).must_equal Backend::Torquebox
      end

      it "alerts about unsupported backend" do
        assert_raises ArgumentError do
          Backend.for(:unsupported_backend)
        end
      end
    end
  end
end
