module Conductor
  module Errors
    # Semantic exception that describes the invocation of an invalid Conductor
    # command
    class InvalidCommandError < NameError
      def initialize(command)
        super("Unknown command '#{command}'", 'InvalidCommandError')
      end

    end
  end
end