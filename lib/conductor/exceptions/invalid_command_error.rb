module Conductor
  module Errors
    class InvalidCommandError < NameError
      attr_reader :innerException

      def initialize(command, innerException = nil)
        @innerException = innerException
        super("#{command} is not a valid command", 'InvalidCommandError')
      end

    end
  end
end