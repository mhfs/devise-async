## Unreleased

* Added torquebox support (astjohn)

## 0.7.0

* make sure options hash has string keys when enqueued and symbol keys when job runs
* stringfy options keys before enqueueing to make queue_classic happy (nickw)
* Added `Devise::Async.enabled=` options to make it easier to skip async processing during tests (mohamedmagdy)

## 0.6.0

* Now compatible with Devise 2.2+ only
* Legacy `Devise::Async::Proxy` is now gone
* `Devise::Async.mailer=` is gone since there's no need for it anymore.
  Use `Devise.mailer` directly.

## 0.5.1

* Lock dependency of 0.5 series on devise < 2.2

## 0.5.0

* Added support for QueueClassic (jperville)
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
