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

      def find(pid)
        @processes.find { |process| process.id == pid}
      end

    end
  end
end