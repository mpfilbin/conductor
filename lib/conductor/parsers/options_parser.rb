require 'optparse'
require_relative '../environment'

module Conductor
  module Parsers
    # This class encapsulates the behavior for parsing commandline arguments and
    # flags passed to Conductor from the commandline
    class OptionsParser
      attr_accessor :verbose, :config_path, :pid_file, :command, :parser, :argv

      # @param[Array] argv
      # @return [Conductor::OptionsParser]
      def self.parse(argv)

        options = OptionsParser.new(argv)

        opt_parser = OptionParser.new do |opts|
          opts.banner = <<-eos
            Usage: conductor <command> [options]:

            Supported commands include...
              - orchestrate <stack_name>: starts up an application stack defined by a stack file
              - ps: lists all of the actively running process along with their PIDs
              - kill <pid>: kills a process with a given PID. Will not restart it.
              - kill_all: kills all processes managed by Conductor

            Supported options:
              -v [--verbose]: Executes a given command verbosely
              -c CONFIG [--config=CONFIG]: Specify a path for your stack files
              -p PIDSFILE [--pids=PIDSFILE]: Specify a path to write PIDs to
          eos

          opts.on('-v', '--verbose', 'Execute commands verbosely') do
            options.send(:verbose=, true)
          end

          opts.on('-c CONFIG', '--config=CONFIG', String, 'Path to the Conductor configuration file') do |config_file_path|
            options.send(:config_path=, config_file_path.strip)
          end

          opts.on('-p PIDS', '--pids=PIDS', String, 'Path to the PIDS file to track processes with') do |pid_file_path|
            options.send(:pid_file=, pid_file_path.strip)
          end
        end

        opt_parser.parse!(argv)
        options

      end

      def initialize(argv = [])
        user_home = Conductor::Environment.fetch('HOME')
        @config_path = "#{user_home}/.orchestration"
        @pid_file = "#{user_home}/.current_pids"
        @verbose, @argv, @command = false, argv, argv.first
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

      def verbose=(verbose)
        @verbose=verbose
      end

      def parser=(parser)
        @parser = parser
      end

    end
  end
end