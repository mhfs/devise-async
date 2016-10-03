require "test_helper"

module Devise
  module Async
    describe "Model" do

      # As per the https://github.com/plataformatec/devise/blob/master/CHANGELOG.md#410,
      # within transaction mail will be enqued & after commit send_devise_pending_notifications will be invoked

      # 1. Within transaction i.e object creation, mails will only be accummulated 
      it "accumulates notifications to be sent after commit on Model creation" do
        admin = create_admin
        Admin.transaction do
          mailers = admin.send(:devise_pending_notifications) # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
          mailers.size.must_equal 0
          Worker.expects(:enqueue).never # after_commit will not fire without save
        end  
        admin[:username] = "changed_username"
        admin.send_confirmation_instructions

        mailers = admin.send(:devise_pending_notifications) # [[:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]]
        mailer = mailers.first              # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
        notification_type = mailer.first    # :confirmation_instructions
        args = mailer.last                  # ["RUQUib67wLcCiEyZMwfx", {}]

        mailers.size.must_equal 1
        mailer.size.must_equal 2
        notification_type.must_equal :confirmation_instructions
        args.must_be_instance_of Array      
        Worker.expects(:enqueue).never # after_commit will not fire without save
      end

      # 2. On explicit save, after commit will be invoked hence notifications will be queued
      it "immediately sends notifications when the model has not changed" do
        Admin.transaction do
          @admin2 = create_admin
          @admin2.save # after_commit will be invoked 
          Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", @admin2.id.to_s, instance_of(String), {})
        end
        Worker.expects(:enqueue).never 
      end
      
      # 3. As data changes, mails are not sent till after_commit is invoked 
      it "accumulates notifications to be sent after commit when Model has been changed" do
        Admin.transaction do
          admin = create_admin

          admin[:username] = "changed_username"
          admin.send_confirmation_instructions

          mailers = admin.send(:devise_pending_notifications) # [[:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]] 
          mailers = mailers.first           # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
          notification_type = mailers.first # :confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]

          mailers.size.must_equal 2         
          notification_type.must_equal :confirmation_instructions
          mailers.last.must_be_instance_of Array
          Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), {})
        end
      end

      # 4. As data changed & saved, i.e after_commit is invoked hence notifications are queued to worker
      it "triggers the enqueued notifications on save" do
        Admin.transaction do
          admin = create_admin

          Worker.expects(:enqueue).never # nothing queued till save 
          admin[:username] = "changed_username"
          admin.send_confirmation_instructions

          mailers = admin.send(:devise_pending_notifications) # [[:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]] 
          mailers = mailers.first           # [:confirmation_instructions, ["RUQUib67wLcCiEyZMwfx", {}]]
          mailers.size.must_equal 2         

          admin.save                     # after_commit will be invoked
          2.times do
            Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), {})
          end
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
          Admin.transaction do
            admin = create_admin
            Worker.expects(:enqueue).never
            admin.save
            Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), { 'locale' => :de })
          end
        end
      end

      describe "default locale set" do

        it "should not set the current locale to the args" do
          Admin.transaction do
            admin = create_admin
            admin.save
            Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s, instance_of(String), {})
          end
          Worker.expects(:enqueue).never
        end
      end
    end
  end
end
