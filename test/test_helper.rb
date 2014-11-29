ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/spec"
require "minitest/mock"
require "mocha/setup"

require "devise"
require "devise/async"
require "rails/all"
require "resque"
require "sidekiq"
require "backburner"
require "delayed_job_active_record"
require "sidekiq/testing"
require "torquebox-no-op"
require "sucker_punch/testing/inline"
require "que"
require "queue_classic"

require "support/rails_app"
require "support/test_helpers"
require "support/my_mailer"

include TestHelpers

load File.dirname(__FILE__) + "/support/rails_app/db/schema.rb"
