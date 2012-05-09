ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "mocha"

require "rails/all"
require "devise"
require "resque"
require "devise_background"

require "support/helpers"

Devise.mailer = "DeviseBackground::Proxy"

module Test
  class RailsApp < ::Rails::Application
    config.root = File.dirname(__FILE__) + "/support/app"
    config.active_support.deprecation = :log
  end
end

Test::RailsApp.initialize!
load File.dirname(__FILE__) + "/support/app/db/schema.rb"
