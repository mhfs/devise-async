ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "mocha"

require "devise_async"
require "rails/all"
require "devise"
require "resque"
require "sidekiq"
require "delayed_job_active_record"

require "support/helpers"

Devise.mailer = "DeviseAsync::Proxy"

module DeviseAsync
  class RailsApp < ::Rails::Application
    config.root = File.dirname(__FILE__) + "/support/rails_app"
    config.active_support.deprecation = :log
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
    config.action_mailer.delivery_method = :test
  end
end

DeviseAsync::RailsApp.initialize!
load File.dirname(__FILE__) + "/support/rails_app/db/schema.rb"
