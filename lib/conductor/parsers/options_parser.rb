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
          opts.banner = 'Usage: conductor <command> [options]'

          opts.on('-v', '--verbose', 'Execute commands verbosely') do
            options.send(:verbose=, true)
          end

          opts.on('-c CONFIG', '--config=CONFIG', String, 'Path to the Conductor configuration file') do |config_file_path|
            options.send(:config_path=, config_file_path.strip())
          end

          opts.on('-p PIDS', '--pids=PIDS', String, 'Path to the PIDS file to track processes with') do |pid_file_path|
            options.send(:pid_file=, pid_file_path.strip())
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