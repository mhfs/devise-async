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
end
