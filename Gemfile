source 'https://rubygems.org'

# Specify your gem's dependencies in devise-async.gemspec
gemspec

case version = ENV['RAILS_VERSION'] || "~> 5.0"
when /5/
  gem "activerecord", "~> 5.0"
  gem "actionpack", "~> 5.0"
  gem "actionmailer", "~> 5.0"
when /4.2/
  gem "activerecord", "~> 4.2"
  gem "actionpack", "~> 4.2"
  gem "actionmailer", "~> 4.2"
else
  gem "activerecord", version
  gem "actionpack", version
  gem "actionmailer", version
end
