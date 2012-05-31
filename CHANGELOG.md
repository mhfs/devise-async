## Unreleased

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
