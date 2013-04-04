module Devise
  module Async
    module Backend
      class Torquebox < Base
        include ::TorqueBox::Messaging::Backgroundable
        always_background :perform

        def self.enqueue(*args)
          new.perform(*args) # using always_background
        end
      end
    end
  end
end
