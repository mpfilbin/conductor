require_relative '../exceptions/invalid_command_error'

include Conductor::Errors

module Conductor
  module CLI
    class Command
      def initialize(argv=nil, options=nil)
        @argv = argv
        @options = options
        @documentation = nil
      end

      def execute
        raise 'Abstract class. Do not instantiate. Please subclass and override'
      end

      def to_s
        "#{simplify(self.class)}: #{documentation}"
      end

      def self.build(command, options)
        parse(command).new(options)
      end

      private
      def self.parse(command)
        begin
          Conductor.const_get("Conductor::#{command.to_s.capitalize}Command")
        rescue Exception => exception
          raise InvalidCommandError.new(command, exception);
        end
      end

      def document(text)
        @documentation = text
      end

      def documentation
        @documentation.nil? ? 'no documentation provided for this command' : @documentation
      end

      def simplify(class_name)
        match = class_name.to_s.match(/^Conductor\:\:([A-Z][a-z]+)(Command)?$/)
        match.nil? ? class_name : match.captures.first
      end
    end
  end
end
