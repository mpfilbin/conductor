module Conductor
  class ApplicationInterface
    attr_reader :home

    def initialize(configuration = {})
      @home = configuration[:home]
      @params = configuration[:params]
      @init = configuration[:start]
      validate!
    end


    def to_s
      "#{path} #{params}"
    end

    private
    def validate!
      if @init.nil?
        raise RuntimeError.new("Stack component cannot be started due to missing command #{self}")
      end
    end

    def params
      @params.join(' ')
    end

    def init
      @init || '???'
    end

    def path
      command = []
      command << home unless home.nil?
      command << init
      command.join(File::SEPARATOR)
    end

  end
end