require_relative 'options_parser'

module Conductor
  class CLI
    def run(argv)
      options = Conductor::OptionsParser.parse(argv)
      command = Conductor::Command.build(argv, options)
      command.exec(argv)
    end
  end
end
