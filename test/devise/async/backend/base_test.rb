require "test_helper"

module Devise
  module Async
    module Backend

      describe "Base" do

        before do
          Devise.mailer = "MyMailer"
          @user         = create_user
        end

        after do
          Devise.mailer = "Devise::Mailer"
        end

        it "delegates to configured mailer" do
          @mailer_instance = mock(:deliver => true)

          MyMailer.expects(:confirmation_instructions).once.returns(@mailer_instance)
          Base.new.perform(:confirmation_instructions, "User", @user.id, {})
        end

        it "executes within the locale scope if a locale is given via args" do
          I18n.expects(:with_locale).once.with(:de)
          Base.new.perform(:confirmation_instructions, "User", @user.id, { 'locale' => :de })
        end

        it "does not execute within the locale scope if no locale is given via args" do
          I18n.expects(:"locale=").never
          Base.new.perform(:confirmation_instructions, "User", @user.id, {})
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
