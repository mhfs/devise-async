require "devise_async/version"

module DeviseAsync
  autoload :Proxy,  "devise_async/proxy"
  autoload :Worker, "devise_async/worker"
end
