require "test_helper"

module Devise
  module Async
    module Backend
      describe "Base" do

        it "delegates to configured mailer" do
          Devise.mailer = "MyMailer"
          user = create_user
          mailer_instance = mock(:deliver => true)

          MyMailer.expects(:confirmation_instructions).once.returns(mailer_instance)
          Base.new.perform(:confirmation_instructions, "User", user.id, {})
        end

        it "delegates to model configured mailer" do
          user = create_user_with_mailer
          mailer_instance = mock(:deliver => true)

          MyMailer.expects(:confirmation_instructions).once.returns(mailer_instance)
          Base.new.perform(:confirmation_instructions, "UserWithMailer", user.id, {})
        end

        describe "the delivery method" do
          before do
            Devise.mailer = "MyMailer"
            @user = create_user
          end

          it "uses #deliver_now when possible" do
            mailer_instance = mock(:deliver_now => true)

            MyMailer.expects(:confirmation_instructions).once.returns(mailer_instance)
            Base.new.perform(:confirmation_instructions, "User", @user.id, {})
          end

          it "uses #deliver otherwise" do
            mailer_instance = mock(:deliver => true)

            MyMailer.expects(:confirmation_instructions).once.returns(mailer_instance)
            Base.new.perform(:confirmation_instructions, "User", @user.id, {})
          end
        end

        after do
          Devise.mailer = "Devise::Mailer"
        end
      end
    end
  end
end
