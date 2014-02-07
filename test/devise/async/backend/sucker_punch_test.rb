require "test_helper"

module Devise
  module Async
    module Backend
      describe "SuckerPunch" do
        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::SuckerPunch.new.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
