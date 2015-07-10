require 'open3'

module Conductor
  module Kernel
    # This class spawns new subprocesses to run conductor applications within
    class Subprocess
      attr_reader :stdout, :stderr, :cmd, :pid_file

      def initialize(interface, pid_file, &block)
        @thread, @stdout, @stderr = nil
        @cmd, @pid_file, @block = interface.to_s, pid_file.call(self), block
        self
      end


      def id
        @thread.pid
      end

      def spawn
        unless pid_file.exists?
          Open3.popen3(@cmd) do |stdin, stdout, stderr, thread|
            stdin.close # We will not be accepting any STDIN, so let's close the descriptor
            @thread = thread
            @stdout, @stderr = stdout, stderr

            @pid_file.open

            {out: stdout, err: stderr}.each do |key, stream|
              Thread.new do
                until (line = stream.gets).nil? do
                  if key == :out
                    @block.call(line, nil, thread, @cmd) if @block
                  else
                    @block.call(nil, line, thread, @cmd) if @block
                  end
                end
              end
              thread.join
            end
          end
        end
      end


      def kill
        if @thread.alive?
          @thread.kill
          @pid_file.close
        end
      end

      def alive?
        @thread.alive?
      end
    end
  end
end