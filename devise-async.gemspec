# -*- encoding: utf-8 -*-
require File.expand_path('../lib/devise_async/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcelo Silveira"]
  gem.email         = ["marcelo@mhfs.com.br"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "devise-async"
  gem.require_paths = ["lib"]
  gem.version       = DeviseAsync::VERSION

  gem.add_dependency "devise"

  gem.add_development_dependency "activerecord", "~> 3.2"
  gem.add_development_dependency "actionpack", "~> 3.2"
  gem.add_development_dependency "actionmailer", "~> 3.2"
  gem.add_development_dependency "mysql2", "~> 0.3"
  gem.add_development_dependency "resque", "~> 1.20"
  gem.add_development_dependency "mocha", "~> 0.11"
end
