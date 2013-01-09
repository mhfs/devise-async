require "test_helper"

module Devise
  module Async
    module Backend
      describe "Base" do
        it "delegates to configured mailer" do
          Async.mailer = "MyMailer"
          user = create_user
          mailer_instance = mock(:deliver => true)

          MyMailer.expects(:confirmation_instructions).once.returns(mailer_instance)
          Base.new.perform(:confirmation_instructions, "User", user.id, {})
        end

        after do
          Async.mailer = "Devise::Mailer"
        end
      end
    end
  end
end
