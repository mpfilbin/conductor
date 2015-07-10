require_relative '../commands/base'
require_relative '../parsers/stack_file_parser'
require_relative '../kernel/subprocess'
require_relative '../kernel/pid_file_writer'
require_relative '../kernel/process_manager'
require_relative '../logging/file_logger'

include Conductor::Parsers
include Conductor::Kernel
include Conductor::Logging

module Conductor
  module Commands
    # This class provides a general interface for starting up an application
    # stack from the commandline
    class OrchestrateCommand < Command
      # @param [Conductor::OptionsParser] options
      def initialize(options, process_manager)
        @application_stack = StackFileParser.new(options)
        @logger = FileLogger.new(options)
        @pid_factory = lambda { |process| PIDFileWriter.new(options, process) }
        super(options, process_manager)
      end

      def execute
        @application_stack.each do |application|
          process = Subprocess.new(application, @pid_factory.call(application)) do |stdout, stderr, process_id, cmd|
            if stdout.nil?
              @logger.info(process_id, cmd, stdout)
            else
              @logger.error(process_id, cmd, stderr)
            end
          end
          process.spawn
          process_manager << process
        end
      end
    end
  end
end
