require "test_helper"

module DeviseAsync
  module Backend
    describe "Resque" do
      it "enqueues job" do
        ::Resque.expects(:enqueue).with(Resque, :mailer_method, "User", 123)
        Resque.enqueue(:mailer_method, "User", 123)
      end

      it "delegates to devise mailer when delivering" do
        user = create_user
        ActionMailer::Base.deliveries = []
        Backend::Resque.perform(:confirmation_instructions, "User", user.id)
        ActionMailer::Base.deliveries.size.must_equal 1
      end
    end
  end
end
