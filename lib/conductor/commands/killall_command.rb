require_relative 'base'

module Conductor
  module Commands
    # This class provides an interface for killing all processes managed by
    # Conductor
    class KillAllCommand < Command
      def initialize
        document 'Kills all processes managed by Orchestrator'
      end

      def execute
        raise NotImplementedError.new('Kill all not implemented yet')
      end
    end
  end
end
