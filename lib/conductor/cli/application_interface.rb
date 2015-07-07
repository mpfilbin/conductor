module Conductor
  # Provides a an abstraction layer over the commandline interfaces for
  # applications declared in Stack files.
  class ApplicationInterface
    attr_reader :home

    def initialize(configuration = {})
      @home = configuration[:home]
      @params = configuration[:params]
      @init = configuration[:start]
      validate
    end


    def to_s
      "#{path} #{params}"
    end

    private
    def validate
        raise RuntimeError.new("Stack component cannot be started due to missing command #{self}") unless @init
    end

    def params
      @params.join(' ')
    end

    def init
      @init || '???'
    end

    def path
      [home, init].compact.join(File::SEPARATOR)
    end

  end
end