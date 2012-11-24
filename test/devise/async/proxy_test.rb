require "test_helper"

module Devise
  module Async
    describe "Proxy" do
      it "gets called by devise operations and proxy to worker" do
        skip "TODO remove when Devise::Async::Proxy is removed in 1.0.0"
        user = create_user
        Worker.expects(:enqueue).with(:confirmation_instructions, "User", user.id.to_s)
        user.send_confirmation_instructions
      end
    end
  end
end
