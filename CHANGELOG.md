## Unreleased

## 0.10.2

* Explicitly requires Devise to avoid an error if Devise is not explicitly mentioned in your Gemfile (@derekprior)
* Improvements for running devise-async locally and on CI
* This will be the last release to support Devise 3.x

## 0.10.1

* No code changes compared to `0.10.1-alpha`

## 0.10.1-alpha

* Backburner support (@jandudulski)
* Sucker Punch support (@kmayer)
* Que support (@marshall-lee)
* Handle `deliver_now` in preparation for Rails 5 (@barelyknown)
* Option to set a priority for DJ and Backburner (@mkon)
* The locale is remembered before an asynchronous task is run (@baschtl)
* Fixed a usage of `try` that appeared in connection with Rails 4 (@baschtl)

## 0.9.0

* Multiple mailers support (@baschtl)
* Update devise dependency to ~3.2

## 0.8.0

* Support arbitrary number of arguments to mailer (@glebm)
* Added torquebox support (@astjohn)

## 0.7.0

* make sure options hash has string keys when enqueued and symbol keys when job runs
* stringfy options keys before enqueueing to make queue_classic happy (@nickw)
* Added `Devise::Async.enabled=` options to make it easier to skip async processing during tests (@mohamedmagdy)

## 0.6.0

* Now compatible with Devise 2.2+ only
* Legacy `Devise::Async::Proxy` is now gone
* `Devise::Async.mailer=` is gone since there's no need for it anymore.
  Use `Devise.mailer` directly.

## 0.5.1

* Lock dependency of 0.5 series on devise < 2.2

## 0.5.0

* Added support for QueueClassic (@jperville)
* Remove deprecated `DeviseAsync::Proxy` and `DeviseAsync.backend=`
* Improved comments throughout code

## 0.4.0

* Enhancements
  * Add support for queue config to DelayedJob backend
  * Use Devise third party modules API insted of including module directly.
    This fixes the ordering issue when including.

## 0.3.1

* Fixes
  * Do not register after_commit unless ORM supports it
  * Only enqueue notifications for after_commit if model is dirty

## 0.3.0

* Fixes
  * Added `Devise::Async::Model` to use new devise's after_commit hooks to resolve #6 (only devise >=2.1.1)

## 0.2.0

* Enhancements
  * Added `Devise::Async.queue` option to let configure the queue
  the jobs will be enqueued to.

## 0.1.1

* Fixes
  * Changed the way we store the record id in the queue to enforce
  compatibility with diferent ORMs

## 0.1.0

* New
	* Added `Devise::Async.mailer` option to proxy to custom mailers
	* Added `Devise::Async.setup` to allow configuring with blocks

## 0.0.2

* Enhancements
	* Restructured gem to Devise::Async module instead of DeviseAsync.

* Deprecations
	* DeviseAsync::Proxy is now Devise::Async::Proxy
	* DeviseAsync.backend is now Devise::Async.backend

## 0.0.1

* first release
