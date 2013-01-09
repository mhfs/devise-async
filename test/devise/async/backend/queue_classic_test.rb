require "test_helper"

module Devise
  module Async
    module Backend
      describe "QueueClassic" do
        it "enqueues job" do
          ::QC::Queue.any_instance.expects(:enqueue).with(
              "Devise::Async::Backend::QueueClassic.perform",
              "mailer_method", "User", 123, {})
          QueueClassic.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::QueueClassic.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end

        it "enqueues to configured queue" do
          queue = mock(:enqueue => nil)
          ::QC::Queue.expects(:new).with(:custom_queue).once.returns(queue)
          QueueClassic.enqueue(:mailer_method, "User", 123, {})
        end
      end
    end
  end
end
