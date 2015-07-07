require 'yaml'
require_relative '../application_interface'


module Conductor
  module CLI
    module Parsers
      # This class encapsulates the logic for loading and parsing stack files in
      # YAML file format
      class StackFileParser

        # @param [Conductor::CLI::OptionsParser] options
        def initialize(stack_name, options)
          @stack_files_dir = options.config_path
          @stack = stack_name
          @stack_file
        end

        def parse
          load.map { |interface| Conductor::ApplicationInterface.new(interface) }
        end

        private
        def load
          @stack_file = YAML::load_file(File.join(@stack_files_dir, "#{@stack}.yml"))
          @stack_file.map { |entry| entry.inject({}) { |memo, (key, value)| memo[key.to_sym] = value; memo } }
        end
      end
    end
  end
end