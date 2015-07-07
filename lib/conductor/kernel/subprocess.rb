require 'open3'

module Conductor
  module Kernel
    # This class spawns new subprocesses to run conductor applications within
    class Subprocess
      attr_reader :stdout, :stderr, :process_id

      def initialize(cmd, &block)
        @process_id, @stdout, @stderr = nil

        Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
          stdin.close
          @process_id = thread.pid if thread.alive?
          @stdout, @stderr = stdout, stderr

          {out: stdout, err: stderr}.each do |key, stream|
            Thread.new do
              until (line = stream.gets).nil? do
                if key == :out
                  block.call(line, nil, thread) if block_given?
                else
                  block.call(nil, line, thread) if block_given?
                end
              end
            end
            thread.join
          end
        end
      end
    end
  end
end