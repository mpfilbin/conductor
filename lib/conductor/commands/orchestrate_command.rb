require_relative '../commands/base'
require_relative '../parsers/stack_file_parser'
require_relative '../kernel/subprocess'
require_relative '../kernel/pid_file'
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
        @pid_factory = lambda { |process| PIDFile.new(options, process) }
        super(options, process_manager)
      end

      def execute
        @application_stack.each do |application|
          process = Subprocess.new(application, @pid_factory) do |stdout, stderr, process_id, cmd|
            {out: stdout, err: stderr}.each do |stream, data|
              message = stream == :out ? :info : :error
              @logger.send(message, process_id, cmd, data) unless data.nil?
            end
          end

          process.spawn
          process_manager << process
        end
      end
    end
  end
end
