require "test_helper"

module Devise
  module Async
    module Backend
      describe "Que" do
        it "enqueues job" do
          Que::Job.expects(:enqueue).with([:mailer_method, "User", 123, {}])
          Que.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::Que.enqueue(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
