require_relative 'options'

module Conductor
  class CLI
    def run(argv)
      options = Conductor::Options.parse(argv)
      command = Conductor::Command.build(argv, options)
      command.exec(argv)
    end
  end
end
