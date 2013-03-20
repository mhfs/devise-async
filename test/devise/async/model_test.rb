require "test_helper"

module Devise
  module Async
    describe "Model" do
      it "accumulates notifications to be sent after commit on Model creation" do
        Admin.transaction do
          admin = create_admin
          admin.send(:devise_pending_notifications).must_equal [[:confirmation_instructions, {}]]
        end
      end

      it "immediately sends notifications when the model has not changed" do
        admin = create_admin
        Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, {})
        admin.send_confirmation_instructions
      end

      it "accumulates notifications to be sent after commit when Model has been changed" do
        admin = create_admin
        Admin.transaction do
          admin[:username] = "changed_username"
          admin.send_confirmation_instructions
          admin.send(:devise_pending_notifications).must_equal [[:confirmation_instructions, {}]]
          Worker.expects(:enqueue).never # after_commit will not fire without save
        end
      end

      it "triggers the enqueued notifications on save" do
        admin = create_admin
        Admin.transaction do
          admin[:username] = "changed_username"
          admin.send_confirmation_instructions
          admin.send(:devise_pending_notifications).must_equal [[:confirmation_instructions, {}]]
          admin.save
          Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, {})
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
    end
  end
end
