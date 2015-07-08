module Orchestrator
  module Logging
    # A factory for generating loggers
    class LoggingFactory
      attr_reader :log_file_path, :log_file_name

      # @param [Conductor::Parsers::OptionsParser]options
      def initialize(options)
        @log_file_path = options.logging_path
        @log_file_name = options.stack_name
      end

      def create_error_logger
        Logger.new(File.open(error_log_path))
      end

      def create_info_logger
        Logger.new(File.open(info_log_file))
      end

      def error_log_path
        log_file_path_for :error
      end

      def info_log_file
        log_file_path_for :info
      end

      private
      def log_file_path_for(log_type)
        path + File::SEPARATOR + [stack_name, log_type.to_s, 'log'].join('.')
      end
    end
  end
end