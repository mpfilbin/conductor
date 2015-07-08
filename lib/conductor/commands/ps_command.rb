require_relative 'base'

module Conductor
  module Commands
    # This class provides an interface for listing all of the actively running processes
    # managed by Conductor
    class PSCommand < Command

      # @param [Conductor::OptionsParser] options
      def initialize(options, process_monitor)
        document 'lists out the currently living processes orchestrated by Orchestrator'
        @process_monitor = process_monitor
        super options
      end

      def execute
        @process_monitor.each do |process|
          puts "#{process.id} : #{process.cmd}"
        end
      end
    end
  end
end
