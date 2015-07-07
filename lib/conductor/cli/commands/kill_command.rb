require_relative '../command'

module Conductor
  module CLI
    module Commands
      # This class provides an interface for killing processes managed by
      # Conductor
      class KillCommand < Command
        # @param [Conductor::OptionsParser] options
        def initialize(options)
          document 'kills a given process orchestrated through Orchestrator'
          super options
        end

        def execute
          raise 'Kill not implemented yet'
        end
      end
    end
  end
end


