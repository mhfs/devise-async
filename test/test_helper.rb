ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "mocha"

require "devise/async"
require "rails/all"
require "devise"
require "resque"
require "sidekiq"
require "delayed_job_active_record"

require "support/helpers"

Devise.mailer = "Devise::Async::Proxy"

# Silent schema load output
ActiveRecord::Migration.verbose = false

module Devise
  module Async
    class RailsApp < ::Rails::Application
      config.root = File.dirname(__FILE__) + "/support/rails_app"
      config.active_support.deprecation = :log
      config.action_mailer.default_url_options = { :host => "localhost:3000" }
      config.action_mailer.delivery_method = :test
    end
  end
end

Devise::Async::RailsApp.initialize!
load File.dirname(__FILE__) + "/support/rails_app/db/schema.rb"
