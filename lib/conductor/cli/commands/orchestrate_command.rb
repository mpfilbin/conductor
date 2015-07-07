require_relative '../command'

module Conductor
  module CLI
    module Commands
      # This class provides a general interface for starting up an application
      # stack from the commandline
      class OrchestrateCommand < Command
        # @param [Conductor::OptionsParser] options
        def initialize(options)
          document 'Initiates the entire orchestration routine'
          super options
        end

        def execute
          raise 'No execution yet'
        end
      end
    end
  end
end
