require "test_helper"

module DeviseAsync
  describe "Worker" do
    it "enqueues job in resque" do
      Resque.expects(:enqueue).with(Worker, :mailer_method, "User", 123)
      Worker.enqueue(:mailer_method, "User", 123)
    end

    it "delegates do devise mailer when delivering" do
      user = create_user
      ActionMailer::Base.deliveries = []
      Worker.perform(:confirmation_instructions, "User", user.id)
      ActionMailer::Base.deliveries.size.must_equal 1
    end
  end
end
