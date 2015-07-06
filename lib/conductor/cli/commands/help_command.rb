require_relative '../command'

include Conductor::CLI

module Conductor
  module CLI
    module Commands
      class HelpCommand < Command

        # @param [Conductor::Options] options
        def initialize(options)
          document 'provides additional information about a particular command'
          super options
        end

        def execute
          puts self.to_s
          puts options.parser
        end
      end
    end
  end
end
