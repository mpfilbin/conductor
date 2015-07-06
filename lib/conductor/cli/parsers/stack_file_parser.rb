require 'yaml'
require_relative '../application_interface'


module Conductor
  module CLI
    module Parsers
      class StackFileParser

        # @param [Conductor::CLI::OptionsParser] options
        def initialize(stack_name, options)
          @stack_files_dir = options.config_path
          @stack = stack_name
        end

        def parse
          load.map { |interface| Conductor::ApplicationInterface.new(interface) }
        end

        private
        def load
          yaml = YAML::load_file(File.join(@stack_files_dir, "#{@stack}.yml"))
          yaml.map { |entry| entry.inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo } }
        end

      end
    end
  end
end