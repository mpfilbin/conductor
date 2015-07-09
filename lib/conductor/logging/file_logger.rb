require 'logger'
module Conductor
  module Logging
    # Provides a simple logger that writes a log to the file system
    class FileLogger < Logger

      # @param [Conductor::Parsers::OptionsParser]options
      def initialize(options)
        path = options.logging_path + File::SEPARATOR + "#{options.stack_name}.log"
        file = File.open(path, File::APPEND)
        set_log_format
        super(file)
      end

      # @param [String] pid
      # @param [String] cmd
      # @param [String] msg
      def info(pid, cmd, msg)
        super("#{pid} #{cmd} -- #{msg}")
      end

      # @param [String] pid
      # @param [String] cmd
      # @param [String] msg
      def error(pid, cmd, msg)
        super("#{pid} #{cmd} #{msg}")
      end

      private
      def set_log_format
        self.formatter = proc do |severity, datetime, progname, msg|
          "#{severity} #{datetime}: #{msg}"
        end
      end

    end
  end
end