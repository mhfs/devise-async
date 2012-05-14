require "active_support/dependencies"
require "devise_async/version"

module DeviseAsync
  autoload :Proxy,  "devise_async/proxy"
  autoload :Worker, "devise_async/worker"
  autoload :Backend, "devise_async/backend"

  module Backend
    autoload :Resque, "devise_async/backend/resque"
    autoload :Sidekiq, "devise_async/backend/sidekiq"
  end

  # Defines the queue backend to be used. Resque by default.
  mattr_accessor :backend
  @@backend = :resque
end
