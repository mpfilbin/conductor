require_relative 'options'

module Conductor
  class CLI
    def run(argv)
      options = Conductor::Option.parse(argv)
      command = Conductor::Command.build(argv, options)
    end
  end
end
