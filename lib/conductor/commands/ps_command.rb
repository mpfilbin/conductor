require_relative 'base'

module Conductor
  module Commands
    # This class provides an interface for listing all of the actively running processes
    # managed by Conductor
    class PSCommand < Command

      # @param [Conductor::OptionsParser] options
      def initialize(options)
        document 'lists out the currently living processes orchestrated by Orchestrator'
        super options
      end

      def execute
        raise 'No PS command yet'
      end
    end
  end
end
