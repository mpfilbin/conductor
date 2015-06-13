require 'optparse'

module Conductor
  class Options
    attr_accessor :verbose, :config_path, :pid_file, :command, :parser

    # @param[Array] argv
    # @return [Conductor::Options]
    def self.parse(argv)

      options = Conductor::Options.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: conductor <command> [options]'

        opts.on('-v', '--verbose', 'Execute commands verbosely') do
          options.send(:verbose=, true)
        end

        opts.on('-c CONFIG', '--config CONFIG', String, 'Path to the Conductor configuration file') do |path|
          options.send(:config_path=, path.strip())
        end

        opts.on('-p PIDS', '--pids PIDS', String, 'Path to the PIDS file to track processes with') do |path|
          options.send(:pid_file=, path.strip())
        end
      end

      opt_parser.parse!(argv)
      options

    end

    def initialize
      @config_path = "#{ENV['HOME']}/.orchestration"
      @pid_file = "#{ENV['HOME']}/.current_pids"
      @verbose = false;
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

  end
end