require "test_helper"

module Devise
  module Async
    module Backend
      describe "Backburner" do
        it "enqueues job" do
          ::Backburner.expects(:enqueue).with(Backburner, :mailer_method, "User", 123, {})
          Backburner.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::Backburner.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end

        describe ".queue_priority" do
          it "returns the right priority when set" do
            Devise::Async.priority = 15
            Backburner.queue_priority.must_equal 15
            Devise::Async.priority = nil
          end

          it "returns default priority when no priority is set" do
            Backburner.queue_priority.must_equal ::Backburner.configuration.default_priority
          end
        end
      end
    end
  end
end
