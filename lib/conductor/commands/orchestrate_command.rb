require_relative '../commands/base'
require_relative '../parsers/stack_file_parser'
require_relative '../kernel/subprocess'
require_relative '../kernel/process_manager'

include Conductor::Parsers
include Conductor::Kernel

module Conductor
  module Commands
    # This class provides a general interface for starting up an application
    # stack from the commandline
    class OrchestrateCommand < Command
      # @param [Conductor::OptionsParser] options
      def initialize(options, process_manager)
        @application_stack = StackFileParser.new(options)
        super(options, process_manager)
      end

      def execute
        @application_stack.each do |application|
          process = Subprocess.new(application) do |stdout, stderr, process_id|

          end
          process.spawn
          process_manager << process
        end
      end
    end
  end
end
