require_relative 'base'

module Conductor
  module Commands
    # This class provides an interface for killing all processes managed by
    # Conductor
    class KillAllCommand < Command
      def initialize(options, process_manager)
        super(options, process_manager)
      end

      def execute
        process_manager.each { |process| process.kill }
      end
    end
  end
end
