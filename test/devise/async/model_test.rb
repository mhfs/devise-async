require "test_helper"

module Devise
  module Async
    describe "Model" do
      it "accumulates notifications to be sent after commit on Model creation" do
        Admin.transaction do
          admin = create_admin
          mailers = admin.send(:devise_pending_notifications) # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
          mailers.size.must_equal 1

          mailer = mailers.first
          mailer.size.must_equal 2
          mailer.first.must_equal :confirmation_instructions
          mailer.last.must_be_instance_of Array
        end
      end

      it "immediately sends notifications when the model has not changed" do
        admin = create_admin
        Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), {})
        admin.send_confirmation_instructions
      end

      it "accumulates notifications to be sent after commit when Model has been changed" do
        admin = create_admin
        Admin.transaction do
          admin[:username] = "changed_username"
          admin.send_confirmation_instructions

          mailers = admin.send(:devise_pending_notifications) # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
          mailers.size.must_equal 1

          mailer = mailers.first
          mailer.size.must_equal 2
          mailer.first.must_equal :confirmation_instructions
          mailer.last.must_be_instance_of Array

          Worker.expects(:enqueue).never # after_commit will not fire without save
        end
      end

      it "triggers the enqueued notifications on save" do
        admin = create_admin
        Admin.transaction do
          admin[:username] = "changed_username"
          admin.send_confirmation_instructions

          mailers = admin.send(:devise_pending_notifications) # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
          mailers.size.must_equal 1

          mailer = mailers.first
          mailer.size.must_equal 2
          mailer.first.must_equal :confirmation_instructions
          mailer.last.must_be_instance_of Array

          admin.save
          Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), {})
        end
      end

      it "should not enqueue a job if the enabled config option is set to false" do
        Devise::Async.stubs(:enabled).returns(false)

        # Stubbing the devise's confirmation_instructions
        confirmation_email = Object.new
        Devise::Mailer.stubs(:confirmation_instructions).returns(confirmation_email)
        confirmation_email.stubs(:deliver).returns(true) # Stubbing the email sending process

        admin = create_admin
        admin.send(:devise_pending_notifications).must_equal []
        Worker.expects(:enqueue).never
      end

      describe "custom locale set" do

        # Set a custom locale
        before { I18n.locale = :de }

        # locale == nil indicates the usage of the default_locale
        after { I18n.locale = nil }

        it "should set the current locale to the args" do
          admin = create_admin
          Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), { 'locale' => :de })
          admin.send_confirmation_instructions
        end
      end

      describe "default locale set" do

        it "should not set the current locale to the args" do
          admin = create_admin
          Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), {})
          admin.send_confirmation_instructions
        end
      end
    end
  end
end
