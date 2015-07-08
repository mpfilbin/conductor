module Conductor
  module Kernel
    # This class manages all of the processes spawned by Conductor
    class ProcessManager
      include Enumerable

      def initialize
        @processes = []
      end

      def each(&block)
        @processes.each { |process| block.call(process) if block_given? }
      end

      def << (process)
        @processes << process
      end

      def push(process)
        @processes << process
      end

      def kill_process(pid)
        begin
          proc = @processes.find { |process| process.id == pid }
          proc.kill
        rescue NoMethodError
          raise RuntimeError.new("No known process with id: #{pid}")
        end
      end

    end
  end
end