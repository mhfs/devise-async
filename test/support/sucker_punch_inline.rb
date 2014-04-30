# require "sucker_punch/testing/inline" has a bug (see https://github.com/brandonhilkert/sucker_punch/pull/57)
require "celluloid/proxies/abstract_proxy"
require "celluloid/proxies/sync_proxy"
require "celluloid/proxies/actor_proxy"

module Celluloid
  class ActorProxy < SyncProxy
    def async(method_name = nil, *args, &block)
      self
    end
  end
end
