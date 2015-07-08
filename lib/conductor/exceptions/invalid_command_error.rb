module Conductor
  module Errors
    # Semantic exception that describes the invocation of an invalid Conductor
    # command
    class InvalidCommandError < NameError
      def initialize(command)
        super("#{command} is not a valid command", 'InvalidCommandError')
      end

    end
  end
end