module Conductor
  module Errors
    # Semantic exception that describes the invocation of an invalid Conductor
    # command
    class InvalidCommandError < NameError
      attr_reader :inner_exception

      def initialize(command, inner_exception = nil)
        @inner_exception = inner_exception
        super("#{command} is not a valid command", 'InvalidCommandError')
      end

    end
  end
end