source 'https://rubygems.org'

# Specify your gem's dependencies in devise-async.gemspec
gemspec

version = ENV['RAILS_VERSION'] || "~> 6.1"

gem "activerecord", version
gem "actionpack", version
gem "actionmailer", version

if version =~ /^4/
  gem 'sqlite3', '~> 1.3.6'
elsif version =~ /^5.2/
  gem 'sqlite3', '~> 1.3.6'
else
  gem 'sqlite3', '~> 1.4'
end
