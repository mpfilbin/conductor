require_relative '../kernel/process_manager'
require_relative '../exceptions/invalid_command_error'


module Conductor
  module Commands
    Dir["#{__dir__}/*_command.rb"].each { |file| require file }
    include Conductor::Kernel
    include Conductor::Errors

    # This class is responsible for generating instances of command classes
    class CommandFactory
      COMMANDS = {
          orchestrate: OrchestrateCommand,
          ps: PSCommand,
          kill: KillCommand,
          kill_all: KillAllCommand
      }

      def initialize
        @process_manager = ProcessManager.new
      end

      def instantiate(options)
        command = options.command

        begin
          return COMMANDS[command].new(options, @process_manager)
        rescue NoMethodError
          raise InvalidCommandError.new(command)
        end
      end
    end
  end
end