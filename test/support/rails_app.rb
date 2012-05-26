# Silent schema load output
ActiveRecord::Migration.verbose = false

module Devise
  module Async
    class RailsApp < ::Rails::Application
      config.root = File.dirname(__FILE__) + "/rails_app"
      config.active_support.deprecation = :log
      config.action_mailer.default_url_options = { :host => "localhost:3000" }
      config.action_mailer.delivery_method = :test
    end
  end
end

Devise::Async::RailsApp.initialize!
