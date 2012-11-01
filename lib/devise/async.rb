require "active_support/dependencies"
require "devise/async/version"

module Devise
  module Async
    autoload :Proxy,   "devise/async/proxy"
    autoload :Worker,  "devise/async/worker"
    autoload :Backend, "devise/async/backend"

    module Backend
      autoload :Base,       "devise/async/backend/base"
      autoload :Resque,     "devise/async/backend/resque"
      autoload :Sidekiq,    "devise/async/backend/sidekiq"
      autoload :DelayedJob, "devise/async/backend/delayed_job"
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

    # Allow configuring Devise::Async with a block
    #
    # Example:
    #
    #     Devise::Async.setup do |config|
    #       config.backend = :resque
    #       config.mailer = "MyMailer"
    #     end
    def self.setup
      yield self
    end
  end
end

# Just to be compatible with first release
# TODO remove when appropriate
module DeviseAsync
  class Proxy < Devise::Async::Proxy
    def initialize(method, resource)
      puts "DEPRECATION WARNING: DeviseAsync::Proxy has been deprecated. Please use Devise::Async::Proxy."
      super
    end
  end

  def self.backend=(value)
    puts "DEPRECATION WARNING: `DeviseAsync.backend=` has been deprecated. Please use `Devise::Async.backend=`."
    Devise::Async.backend = value
  end
end

Devise.add_module(:async, :model => 'devise/async/model')
