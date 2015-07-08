require_relative '../exceptions/invalid_command_error'

include Conductor::Errors

module Conductor
  # Abstract base class from which all other CLI commands are derived. Provides
  # some basic functionality that derived classes can leverage.
  class Command
    attr_reader :options, :process_manager

    def initialize(options = nil, process_manager = nil)
      @options = options
      @process_manager = process_manager
    end

    def execute
      raise 'Abstract class. Do not instantiate. Please subclass and override'
    end
  end
end
