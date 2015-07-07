require 'yaml'
require_relative '../../../lib/conductor/applications/stack'

include Conductor::Applications

module Conductor
  module Parsers
    # This class encapsulates the logic for loading and parsing stack files in
    # YAML file format
    class StackFileParser
      attr_reader :file_contents

      # @param [Conductor::CLI::OptionsParser] options
      def initialize(stack_name = nil, options = nil)
        @stack_file_path = File.join(options.config_path, "#{stack_name}.yml")
        read_file_contents
      end

      def parse
        Stack.new(contents_with_symbolized_keys)
      end

      private
      def read_file_contents
        @file_contents = YAML.load_file(@stack_file_path)
      end

      def contents_with_symbolized_keys
        file_contents.map {|content| Hash[content.map{ |key, value| [key.to_sym, value]}]}
      end
    end
  end
end