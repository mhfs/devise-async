module DeviseAsync
  module Backend
    def self.for(backend)
      const_get(backend.to_s.camelize)
    rescue NameError
      raise ArgumentError, "unsupported backend for devise-async."
    end
  end
end
