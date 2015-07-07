module Conductor
  # Provides a simple layer of indirection between the runtime environment
  # and the application

  class Environment
    def self.fetch(key)
      ENV[key.to_s]
    end

    def self.set(key, value)
      ENV[key.to_s] = value
    end

  end
end