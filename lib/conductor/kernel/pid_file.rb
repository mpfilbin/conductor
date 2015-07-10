module Conductor
  module Kernel
    # Writs the process id for a process managed by conductor to .pid file
    class PIDFile
      attr_reader :file_path

      # @param [Conductor::Parsers::OptionsParser]options
      # @param [Conductor::Kernel::Subprocess]process
      def initialize(options, process)
        @file_path, @proc = options.pid_path, process
      end

      def open
        File.open(pid_file, ::File::CREAT | ::File::EXCL | ::File::WRONLY) do |file|
          file.write("#{process.id}")
        end
      end

      def close
        File.delete(pid_file) if exists?
      end

      def exists?
        File.exists?(pid_file)
      end

    end

    private
    def pid_file
      @file_path + File::SEPARATOR + process.cmd + '.pid'
    end

    def process
      @proc
    end
  end
end