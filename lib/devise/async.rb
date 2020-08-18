require 'devise'
require 'devise/async/model'
require 'devise/async/version'
require 'action_mailer'

module Devise
  module Async
    # Defines the enabled configuration that if set to false the emails will be sent synchronously
    mattr_accessor :enabled
    @@enabled = true

    # Defines the queue in which the background job will be enqueued.
    mattr_accessor :queue
    @@queue = ActionMailer::Base.deliver_later_queue_name

    # Allow configuring Devise::Async with a block
    #
    # Example:
    #
    #     Devise::Async.setup do |config|
    #       config.enabled = false
    #     end
    def self.setup
      yield self
    end
  end
end

# Register devise-async model in Devise
Devise.add_module(:async, model: 'devise/async/model')
