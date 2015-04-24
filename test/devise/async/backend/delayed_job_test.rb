require "test_helper"

module Devise
  module Async
    module Backend
      describe "DelayedJob" do
        before do
          Devise::Async.delayed_job_priority = -1
        end

        it "enqueues job" do
          delayed_instance = mock()
          delayed_instance.expects(:perform).once.with(:mailer_method, "User", 123, {})
          DelayedJob.any_instance.expects(:delay).once.with(queue: :custom_queue, priority: -1).returns(delayed_instance)

          DelayedJob.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::DelayedJob.new.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
