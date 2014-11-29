require "active_support/dependencies"
require "devise/async/version"

module Devise
  module Async
    autoload :Worker,  "devise/async/worker"
    autoload :Backend, "devise/async/backend"
    autoload :Model,   "devise/async/model"

    module Backend
      autoload :Base,         "devise/async/backend/base"
      autoload :Backburner,   "devise/async/backend/backburner"
      autoload :Resque,       "devise/async/backend/resque"
      autoload :Sidekiq,      "devise/async/backend/sidekiq"
      autoload :DelayedJob,   "devise/async/backend/delayed_job"
      autoload :QueueClassic, "devise/async/backend/queue_classic"
      autoload :Torquebox,    "devise/async/backend/torquebox"
      autoload :SuckerPunch,  "devise/async/backend/sucker_punch"
      autoload :Que,          "devise/async/backend/que"
    end

    # Defines the queue backend to be used. Resque by default.
    mattr_accessor :backend
    @@backend = :resque

    # Defines the queue in which the background job will be enqueued. Default is :mailer.
    mattr_accessor :queue
    @@queue = :mailer

    # Defines the enabled configuration that if set to false the emails will be sent synchronously
    mattr_accessor :enabled
    @@enabled = true

    # Allow configuring Devise::Async with a block
    #
    # Example:
    #
    #     Devise::Async.setup do |config|
    #       config.backend = :resque
    #       config.queue   = :my_custom_queue
    #     end
    def self.setup
      yield self
    end
  end
end

# Register devise-async model in Devise
Devise.add_module(:async, :model => 'devise/async/model')
