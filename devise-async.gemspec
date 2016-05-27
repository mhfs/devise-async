# -*- encoding: utf-8 -*-
require File.expand_path('../lib/devise/async/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "devise-async"
  gem.version       = Devise::Async::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Marcelo Silveira"]
  gem.email         = ["marcelo@mhfs.com.br"]
  gem.description   = %q{Send Devise's emails in background. Supports Backburner, Resque, Sidekiq, Delayed::Job, QueueClassic, Que, Sucker Punch and Torquebox.}
  gem.summary       = %q{Devise Async provides an easy way to configure Devise to send its emails asynchronously using your preferred queuing backend. It supports Backburner, Resque, Sidekiq, Delayed::Job, QueueClassic, Que, Sucker Punch and Torquebox.}
  gem.homepage      = "https://github.com/mhfs/devise-async/"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ["lib"]


  gem.add_dependency "devise", ">= 3.2", "< 4.0"

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "activerecord",              ">= 3.2"
  gem.add_development_dependency "actionpack",                ">= 3.2"
  gem.add_development_dependency "actionmailer",              ">= 3.2"
  gem.add_development_dependency "sqlite3",                   "~> 1.3"
  gem.add_development_dependency "resque",                    "~> 1.20"
  gem.add_development_dependency "sidekiq",                   "~> 2.17"
  gem.add_development_dependency "delayed_job_active_record", "~> 0.3"
  gem.add_development_dependency "queue_classic",             "~> 2.0"
  gem.add_development_dependency "backburner",                "~> 0.4"
  gem.add_development_dependency "mocha",                     "~> 0.11"
  gem.add_development_dependency "torquebox-no-op",           "~> 2.3"
  gem.add_development_dependency "sucker_punch",              "~> 1.0.5"
  gem.add_development_dependency "que",                       "~> 0.8"
end
