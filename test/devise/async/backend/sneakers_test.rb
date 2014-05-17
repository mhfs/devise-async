require "test_helper"
require "sneakers/publisher"

module Devise
  module Async
    module Backend
      describe "Sneakers" do
        it "enqueues job" do
          ::Sneakers::Publisher.any_instance.expects(:publish).once.with([:mailer_method, "User", 123, {}].to_json, "devise_mailer")
          Sneakers.enqueue(:mailer_method, "User", 123, {})
        end

        it "delegates to devise mailer when delivering" do
          user = create_user
          ActionMailer::Base.deliveries = []
          Backend::Sneakers.new.work([:confirmation_instructions, "User", user.id, {}].to_json)
          ActionMailer::Base.deliveries.size.must_equal 1
        end
      end
    end
  end
end
