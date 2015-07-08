require 'open3'

module Conductor
  module Kernel
    # This class spawns new subprocesses to run conductor applications within
    class Subprocess
      attr_reader :stdout, :stderr

      def initialize(cmd, &block)
        @thread, @stdout, @stderr = nil
        @cmd, @block = cmd.to_s, block
        self
      end


      def id
        @thread.pid
      end

      def spawn
        Open3.popen3(@cmd) do |stdin, stdout, stderr, thread|

          stdin.close # We will not be accepting any STDIN, so let's close the descriptor
          @thread = thread
          @stdout, @stderr = stdout, stderr

          {out: stdout, err: stderr}.each do |key, stream|
            Thread.new do
              until (line = stream.gets).nil? do
                if key == :out
                  @block.call(line, nil, thread) if @block
                else
                  @block.call(nil, line, thread) if @block
                end
              end
            end
            thread.join
          end
        end
      end

      def kill
        @thread.kill if @thread.alive?
      end

      def alive?
        @thread.alive?
      end
    end
  end
end