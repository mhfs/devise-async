ENV['RAILS_ENV'] ||= 'test'

require 'devise'
require 'devise/async'
require 'rails/all'

require 'spec_helper'
require 'rspec/rails'
require 'pry'

require 'support/rails_app'
require 'support/test_helpers'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include TestHelpers

  config.before :each do
    load "#{File.dirname(__FILE__)}/support/rails_app/db/schema.rb"
  end
end
