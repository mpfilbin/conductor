require_relative 'base'

module Conductor
  module Commands
    # This class provides an interface for getting helpful information about
    # Conductor and its subcommands
    class HelpCommand < Command

      # @param [Conductor::OptionsParser] options
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
