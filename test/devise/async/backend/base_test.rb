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

        it "delegates to a mailer that uses options" do
          Async.mailer = "OptionsMailer"
          user = create_user
          mailer_instance = mock(:deliver => true)

          OptionsMailer.expects(:reset_password_instructions).with(user, {:a => 1}).returns(mailer_instance)
          Base.new.perform(:reset_password_instructions, "User", user.id, {:a => 1})
        end

        it "performs a callback" do
          Async.callback = true
          user = create_user
          mailer_instance = mock(:deliver => true)

          Devise::Mailer.expects(:confirmation_instructions).once.returns(mailer_instance)

          User.any_instance.expects(:devise_mail_sent).once
          assert user.respond_to?(:devise_mail_sent)

          Base.new.perform(:confirmation_instructions, "User", user.id, user.mail_options(:confirmation_instructions))
        end

        it "does not perform a callback for models without the method" do
          Async.callback = true
          admin = create_admin
          mailer_instance = mock(:deliver => true)

          Devise::Mailer.expects(:confirmation_instructions).once.returns(mailer_instance)

          # Cannot do this properly as mocha adds missing methods that are expected...!
          # If had access to the instance (rather than Class.any_instance) could use
          # responds_like but there isn't!
          # Ideally it would be:
          # Admin.any_instance.responds_like(Admin.new)
          # Admin.any_instance.expects(:devise_mail_sent).never
          # Instead, turned off stubbing of non-existent methods in Mocha config,
          # hence testing to ensure that exception is raised on the mock objects.
          assert_raises Mocha::StubbingError do
            Admin.any_instance.expects(:devise_mail_sent).never
          end
          assert !admin.respond_to?(:devise_mail_sent)

          Base.new.perform(:confirmation_instructions, "Admin", admin.id, nil)
        end

        it "does not perform a callback" do
          Async.callback = false
          user = create_user
          mailer_instance = mock(:deliver => true)

          Devise::Mailer.expects(:confirmation_instructions).once.returns(mailer_instance)
          User.any_instance.expects(:devise_mail_sent).never
          assert user.respond_to?(:devise_mail_sent)

          Base.new.perform(:confirmation_instructions, "User", user.id, user.mail_options(:confirmation_instructions))
        end

        after do
          Async.mailer = "Devise::Mailer"
          Async.callback = false
        end
      end
    end
  end
end
