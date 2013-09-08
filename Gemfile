source 'https://rubygems.org'

group :development do
  platforms :ruby do
    gem 'sqlite3',       '~> 1.3'
    gem 'queue_classic', '~> 2.1'
  end

  platforms :jruby do
    gem 'jdbc-sqlite3',  '~> 3.7.2'
    gem 'jdbc-postgres', '~> 9.2'

    gem 'activerecord-jdbc-adapter',        '~> 1.2.9'
    gem 'activerecord-jdbcsqlite3-adapter', '~> 1.2.9'

    gem 'queue_classic_java', github: 'bdon/queue_classic_java', ref: '148c790c924a5994bdd8b95ab0b0baad3b0ff948'
  end
end

# Specify your gem's dependencies in devise-async.gemspec
gemspec
