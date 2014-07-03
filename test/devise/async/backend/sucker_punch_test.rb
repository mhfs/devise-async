require "test_helper"

module Devise
  module Async
    module Backend
      describe "SuckerPunch" do
        it "enqueues job" do
          Celluloid.boot
          SuckerPunch.expects(:perform).with(:mailer_method, "User", 123, {})
          SuckerPunch.enqueue(:mailer_method, "User", 123, {})
        end

        it "ensures the connection is returned back to the pool when completed" do
          ActionMailer::Base.deliveries = []
          ActiveRecord::ConnectionAdapters::ConnectionPool.any_instance.expects(:with_connection).once
          Backend::SuckerPunch.new.perform(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::SuckerPunch.new.perform(:confirmation_instructions, "User", user.id, {})
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
