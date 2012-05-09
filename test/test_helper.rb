ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "mocha"

require "devise_background"
require "rails/all"
require "devise"
require "resque"

require "support/helpers"

Devise.mailer = "DeviseBackground::Proxy"

module DeviseBackground
  class RailsApp < ::Rails::Application
    config.root = File.dirname(__FILE__) + "/support/app"
    config.active_support.deprecation = :log
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
    config.action_mailer.delivery_method = :test
  end
end

DeviseBackground::RailsApp.initialize!
load File.dirname(__FILE__) + "/support/app/db/schema.rb"
