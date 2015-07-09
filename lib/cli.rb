require_relative('conductor/commands/command_factory')
include Conductor::Commands

module Conductor
  # The CLI class coordinates parsing of commandline options
  #  and execution of commands
  class CLI
    # @param [Conductor::Parsers::OptionsParser]options
    # @param [Conductor::Commands:CommandFactory]factory
    def initialize(options, factory)
      @command = factory.instantiate(options)
    end
    def run
      @command.execute
    end
  end
end
