require 'optparse'
require_relative '../environment'

module Conductor
  module Parsers
    # This class encapsulates the behavior for parsing commandline arguments and
    # flags passed to Conductor from the commandline
    class OptionsParser
      attr_accessor :verbose, :config_path, :pid_file, :command, :parser, :stack_name, :logging_path

      # @param[Array] argv
      # @return [Conductor::OptionsParser]
      def self.parse(argv)

        options = OptionsParser.new(argv)

        opt_parser = OptionParser.new do |opts|
          opts.banner = <<-eos
            Usage: conductor <command> <stack_name> [parameters] [options]:

            Supported commands include...
              - orchestrate <stack_name>: starts up an application stack defined by a stack file
              - ps: lists all of the actively running process along with their PIDs
              - kill <pid>: kills a process with a given PID. Will not restart it.
              - kill_all: kills all processes managed by Conductor

            Supported options:
              -c CONFIG [--config=CONFIG]: Specify a path for your stack files
              -p PIDSFILE [--pids=PIDSFILE]: Specify a path to write PIDs to
              -l LOGGINGPATH [--logging-path=LOGGINGPATH]: Path to write error and log files for stack

            Example:

            conductor killall app_stack     #=> Kills all processes defined by 'app_stack'
            conductor kill app_stack 1390   #=> Kills process with ID 1390 in 'app_stack'
            conductor orchestrate app_stack #=> Orchestrate applications defined by 'app_stack'
          eos

          opts.on('-c CONFIG', '--config=CONFIG', String, 'Path to the Conductor configuration file') do |config_file_path|
            options.send(:config_path=, config_file_path.strip)
          end

          opts.on('-p PIDS', '--pids=PIDS', String, 'Path to the PIDS file to track processes with') do |pid_file_path|
            options.send(:pid_file=, pid_file_path.strip)
          end

          opts.on('-l LOGGINGPATH', '--logging-path=LOGGINGPATH', String, 'Path to the directory where log file will be written') do |log_file_path|
            options.send(:logging_path=, log_file_path.strip)
          end

        end

        opt_parser.parse!(argv)

        options

      end

      def initialize(argv = [])
        user_home = Conductor::Environment.fetch('HOME')
        @config_path = "#{user_home}/.orchestration"
        @pid_file = "#{user_home}/.current_pids"
        @logging_path = '/var/log'
        @verbose, @command, @stack = false, argv[0], argv[1]
      end

      def command
        @command.to_s.to_sym
      end

      private
      def pid_file=(pid)
        @pid_file = pid
      end

      def config_path=(config)
        @config_path = config
      end

      def logging_path=(path)
        @logging_path = path
      end

    end
  end
end