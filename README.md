# Devise Async [![Build Status](https://secure.travis-ci.org/mhfs/devise-async.png)](http://travis-ci.org/mhfs/devise-async)

Devise Async provides an easy way to configure Devise to send its emails asynchronously using your preferred queuing backend.

Supported backends:

* Resque
* Sidekiq
* Delayed::Job
* QueueClassic
* Torquebox
* Backburner
* Que

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

Add `:async` to the `devise` call in your model:

```ruby
class User < ActiveRecord::Base
  devise :database_authenticatable, :async, :confirmable # etc ...
end
```

Set your queuing backend by creating `config/initializers/devise_async.rb`:

```ruby
# Supported options: :resque, :sidekiq, :delayed_job, :queue_classic, :torquebox, :backburner, :que
Devise::Async.backend = :resque
```

Tip: it defaults to Resque. You don't need to create the initializer if using it.

## Advanced Options

### Enabling via config

The gem can be enabled/disabled easily via config, for example based on environment.

```ruby
# config/initializers/devise_async.rb
Devise::Async.enabled = true # | false
```

### Custom mailer class

Customize `Devise.mailer` at will and `devise-async` will honor it.

Upgrade note: if you're upgrading from any version < 0.6 and getting errors
trying to set `Devise::Async.mailer` just use `Devise.mailer` instead.

### Custom queue

Let you specify a custom queue where to enqueue your background Devise jobs.
Defaults to :mailer.

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
  config.enabled = true
  config.backend = :resque
  config.queue   = :my_custom_queue
end
```

## Testing

Be aware that since version 0.3.0 devise-async enqueues the background job in active
record's `after_commit` hook. If you're using rspec's `use_transactional_fixtures` the jobs
might not be enqueued as you'd expect.

More details in this stackoverflow [thread](http://stackoverflow.com/questions/13406248/how-do-i-get-devise-async-working-with-cucumber/13465089#13465089).

## Devise < 2.2

Older versions of Devise are supported in the [devise_2_1](https://github.com/mhfs/devise-async/tree/devise_2_1) branch and in the 0.5 series of devise-async.

Please refer to that branch README for further info.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT License. See the [LICENSE][license] file for further details.

[license]: https://github.com/mhfs/devise-async/blob/master/LICENSE
