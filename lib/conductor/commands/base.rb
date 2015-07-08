require_relative '../exceptions/invalid_command_error'

include Conductor::Errors

module Conductor
  # Abstract base class from which all other CLI commands are derived. Provides
  # some basic functionality that derived classes can leverage.
  class Command
    attr_reader :options

    def initialize(options = nil)
      @options = options
      @documentation = nil
    end

    def execute
      raise 'Abstract class. Do not instantiate. Please subclass and override'
    end

    def to_s
      "#{self.class.to_s}: #{documentation}"
    end

    private
    def document(text)
      @documentation = text
    end

    def documentation
      @documentation ||= 'no documentation provided for this command'
    end

  end
end
