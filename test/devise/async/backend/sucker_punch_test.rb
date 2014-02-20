require "test_helper"

module Devise
  module Async
    module Backend
      describe "SuckerPunch" do
=begin
        it "enqueus the job" do
          sucker_punch_instance = mock()
          sucker_punch_instance.expects(:perform).once.with(:mailer_method, "User", 123, {})
          SuckerPunch.any_instance.expects(:async).once.returns(sucker_punch_instance)

          SuckerPunch.enqueue(:mailer_method, "User", 123, {})
        end
=end
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
