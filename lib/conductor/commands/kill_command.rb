require_relative 'base'

module Conductor
  module Commands
    # This class provides an interface for killing processes managed by
    # Conductor
    class KillCommand < Command
      # @param [Conductor::OptionsParser] options
      def initialize(options, process_manager)
        document 'kills a given process orchestrated through Orchestrator'
        @process_manager = process_manager
        super options
      end

      def execute
        @process_manager.find(options.argv[1]).kill
      end
    end
  end
end


