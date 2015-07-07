require_relative 'options_parser'

module Conductor
  # The CLI class coordinates parsing of commandline options
  #  and execution of commands
  class CLI
    def initialize(argv)
      @options = Conductor::OptionsParser.parse(argv)
      @command = Conductor::Command.build(argv, options)
    end
    def run(argv)
      @command.exec(argv)
    end
  end
end
