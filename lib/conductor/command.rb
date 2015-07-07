require_relative 'exceptions/invalid_command_error'

include Conductor::Errors

module Conductor
  # Abstract base class from which all other CLI commands are derived. Provides
  # some basic functionality that derived classes can leverage.
  class Command
    def initialize(argv=nil, options=nil)
      @argv = argv
      @options = options
      @documentation = nil
    end

    def execute
      raise 'Abstract class. Do not instantiate. Please subclass and override'
    end

    def to_s
      "#{self.class.to_s}: #{documentation}"
    end

    def self.build(command, options)
      parse(command).new(options)
    end

    private
    def self.parse(command)
      begin
        Conductor.const_get("Conductor::#{command.to_s.capitalize}Command")
      rescue Exception => exception
        raise InvalidCommandError.new(command, exception);
      end
    end

    def document(text)
      @documentation = text
    end

    def documentation
      @documentation ||= 'no documentation provided for this command'
    end

  end
end
