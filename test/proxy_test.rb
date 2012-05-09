require "test_helper"

module DeviseAsync
  describe "Proxy" do
    it "gets called by devise operations and proxy to worker" do
      user = create_user
      Worker.expects(:enqueue).with(:confirmation_instructions, "User", user.id)
      user.send_confirmation_instructions
    end
  end
end
