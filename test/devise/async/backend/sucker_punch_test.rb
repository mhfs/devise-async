require "test_helper"

module Devise
  module Async
    module Backend
      describe "SuckerPunch" do
        it "enqueus the job" do
          SuckerPunch.any_instance.expects(:perform).once.with(:mailer_method, "User", 123, {})
          SuckerPunch.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          SuckerPunch.new.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
