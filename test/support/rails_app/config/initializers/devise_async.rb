Devise::Async.setup do |config|
  config.queue = :custom_queue
end
