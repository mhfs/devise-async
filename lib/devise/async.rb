require "active_support/dependencies"
require "devise/async/version"

module Devise
  module Async
    autoload :Proxy,   "devise/async/proxy"
    autoload :Worker,  "devise/async/worker"
    autoload :Backend, "devise/async/backend"
    autoload :Model,   "devise/async/model"

    module Backend
      autoload :Base,         "devise/async/backend/base"
      autoload :Resque,       "devise/async/backend/resque"
      autoload :Sidekiq,      "devise/async/backend/sidekiq"
      autoload :DelayedJob,   "devise/async/backend/delayed_job"
      autoload :QueueClassic, "devise/async/backend/queue_classic"
    end

    # Defines the queue backend to be used. Resque by default.
    mattr_accessor :backend
    @@backend = :resque

    # Defines the mailer class to be used. Devise::Mailer by default.
    mattr_accessor :mailer
    @@mailer = "Devise::Mailer"

    # Defines the queue in which the background job will be enqueued. Default is :mailer.
    mattr_accessor :queue
    @@queue = :mailer

    # Defines whether the callback hook should be called on the model. Note this uses
    # respond_to? so can be left on for models that don't have the method. This expects
    # a method called *mail_sent* to exist on the model and it will be passed the template
    # that devise has mailed out. This allows any logging or processing that needs to
    # occur after a mail has actually gone out to be handled. Note that it does not
    # guarantee mail delivery; just that it has left the rails system!
    mattr_accessor :callback
    @@callback = false

    # Allow configuring Devise::Async with a block
    #
    # Example:
    #
    #     Devise::Async.setup do |config|
    #       config.backend  = :resque
    #       config.mailer   = "MyMailer"
    #       config.queue    = :my_custom_queue
    #       config.callback = true
    #     end
    def self.setup
      yield self
    end
  end
end

# Register devise-async model in Devise
Devise.add_module(:async, :model => 'devise/async/model')
