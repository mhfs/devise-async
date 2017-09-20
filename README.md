# Devise Async

[![Tag](https://img.shields.io/github/tag/mhfs/devise-async.svg?style=flat-square)](https://github.com/mhfs/devise-async/releases) [![Build Status](https://img.shields.io/travis/mhfs/devise-async.svg?style=flat-square)](https://travis-ci.org/mhfs/devise-async) [![Code Climate](https://img.shields.io/codeclimate/github/mhfs/devise-async.svg?style=flat-square)](https://codeclimate.com/github/mhfs/devise-async)

Devise Async provides an easy way to configure Devise to send its emails asynchronously using ActiveJob.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise-async'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devise-async

## Usage

1. Setup [ActiveJob](http://edgeguides.rubyonrails.org/active_job_basics.html),
2. Add `:async` to the `devise` call in your model:

```ruby
class User < ActiveRecord::Base
  devise :database_authenticatable, :async, :confirmable # etc ...
end
```

## Options

### Enabling via config

The gem can be enabled/disabled easily via config, for example based on environment.

```ruby
# config/initializers/devise_async.rb
Devise::Async.enabled = true # | false
```

### Setup via block

To avoid repeating `Devise::Async` in the initializer file you can use the block syntax
similar to what `Devise` offers.

```ruby
# config/initializers/devise_async.rb
Devise::Async.setup do |config|
  config.enabled = true
end
```

### Custom mailer class

Customize `Devise.mailer` at will and `devise-async` will honor it.

## Older versions of Rails and devise

If you want to use this gem with Rails < 5 and/or devise < 4 check out older releases, please.

## Testing

RSpec is used for testing. The following should be enough for running the test:

    $ bundle exec rspec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT License. See the [LICENSE][license] file for further details.

[license]: https://github.com/mhfs/devise-async/blob/master/LICENSE
