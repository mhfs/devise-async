# Devise Async [![Build Status](https://secure.travis-ci.org/mhfs/devise-async.png)](http://travis-ci.org/mhfs/devise-async)

Devise Async provides an easy way to configure Devise to send its emails asynchronously using your preferred queuing backend.

Supported backends:

* Resque
* Sidekiq
* Delayed::Job

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

### Devise >= 2.1.1

Include `Devise::Async::Model` to your Devise model

```ruby
class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable # etc ...

  include Devise::Async::Model # should be below call to `devise`
end
```

### Devise < 2.1.1

Set `Devise::Async::Proxy` as Devise's mailer in `config/initializers/devise.rb`:

```ruby
# Configure the class responsible to send e-mails.
config.mailer = "Devise::Async::Proxy"
```
### All

Set your queuing backend by creating `config/initializers/devise_async.rb`:

```ruby
# Supported options: :resque, :sidekiq, :delayed_job
Devise::Async.backend = :resque
```

Tip: it defaults to Resque. You don't need to create the initializer if using it.

## Advanced Options

### Custom mailer class

If you inherit `Devise::Mailer` to a class of your own for customization purposes,
you'll need to tell `Devise::Async` to proxy to that class.

```ruby
# config/initializers/devise_async.rb
Devise::Async.mailer = "MyCustomMailer"
```

### Custom queue

Let you specify a custom queue where to enqueue your background Devise jobs. Works
only for Resque and Sidekiq. Defaults to :mailer.

```ruby
# config/initializers/devise_async.rb
Devise::Async.queue = :my_custom_queue
```

### Setup via block

To avoid repeating `Devise::Async` in the initializer file you can use the block syntax
similar do what `Devise` offers.

```ruby
# config/initializers/devise_async.rb
Devise::Async.setup do |config|
  config.backend = :resque
  config.mailer  = "MyCustomMailer"
  config.queue   = :my_custom_queue
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT License. See the [LICENSE][license] file for further details.

[license]: https://github.com/mhfs/devise-async/blob/master/LICENSE
