require "test_helper"

module Devise
  module Async
    module Backend
      describe "Torquebox" do
        it "enqueues job" do
          Torquebox.any_instance.expects(:perform).with(:mailer_method, "User", 123, {})
          Torquebox.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::Torquebox.new.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
