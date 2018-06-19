require File.expand_path('../lib/devise/async/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'devise-async'
  gem.version       = Devise::Async::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Sebastian Oelke', 'Marcelo Silveira']
  gem.email         = ['dev@soelke.de', 'marcelo@mhfs.com.br']
  gem.summary       = %q{Deliver Devise's emails in the background using ActiveJob.}
  gem.description   = %q{Devise Async provides an easy way to configure Devise to send its emails asynchronously using ActiveJob.}
  gem.homepage      = 'https://github.com/mhfs/devise-async/'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ['lib']


  gem.add_runtime_dependency 'devise', '>= 4.0'
  gem.add_runtime_dependency 'activejob', '>= 4.2'

  gem.add_development_dependency 'rspec',        '~> 3.6'
  gem.add_development_dependency 'rspec-rails',  '~> 3.6'
  gem.add_development_dependency 'sqlite3',      '~> 1.3'
  gem.add_development_dependency 'pry'
end
