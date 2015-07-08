require_relative '../kernel/process_manager'
require_relative '../exceptions/invalid_command_error'


module Conductor
  module Commands
    Dir["#{__dir__}/*_command.rb"].each { |file| require file }
    include Conductor::Kernel
    include Conductor::Errors

    # This class is responsible for generating instances of command classes
    class CommandFactory
      def initialize
        @process_manager = ProcessManager.new
      end

      def instantiate(options)
        command = options.command

        case command
          when 'orchestrate'
            OrchestrateCommand.new(options, @process_manager)
          else
            raise InvalidCommandError.new("Unknown command #{command}")
        end
      end
    end
  end
end