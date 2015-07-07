require_relative '../command'
require_relative '../parsers/stack_file_parser'
require_relative '../kernel/subprocess'

include Conductor::Parsers
include Conductor::Kernel

module Conductor
  module Commands
    # This class provides a general interface for starting up an application
    # stack from the commandline
    class OrchestrateCommand < Command
      # @param [Conductor::OptionsParser] options
      def initialize(options)
        document 'Initiates the entire orchestration routine'
        @application_stack = StackFileParser.new(options.argv[1], options)
        super options
      end

      def execute
        @application_stack.each do |application|
          Subprocess.new(application.to_s)
        end
      end
    end
  end
end
