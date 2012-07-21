require "test_helper"

module Devise
  module Async
    describe "Model" do
      it "accumulates notifications to be send after commit" do
        admin = create_admin
        admin.send_confirmation_instructions
        admin.send(:devise_pending_notifications).must_equal [:confirmation_instructions]
        Worker.expects(:enqueue).never
      end

      it "triggers enqueues the notifications on save" do
        admin = create_admin
        admin.send_confirmation_instructions
        Worker.expects(:enqueue).with(:confirmation_instructions, "Admin", admin.id.to_s)
        admin.update_attribute(:username, "newusername")
      end
    end
  end
end
