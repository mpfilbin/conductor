module Conductor

  class Command
    attr_reader :documentation

    def initialize(options=nil)
      @options = options
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
      Conductor.const_get("#{command.to_s.capitalize}Command")
    end

    def document(text)
      @documentation = text || 'no documentation provided for ths command'
    end

    def simplify(class_name)
      self.to_s.gsub(/Command$/, '')
    end
  end

  class HelpCommand < Command
    # @param [Conductor::Options] options
    def initialize(options)
      document 'provides additional information about a particular command'
      super options
    end

    def execute
      puts options.parser
    end
  end

  class OrchestrateCommand < Command

    def initialize(options)
      document 'Initiates the entire orchestration routine'
      super options
    end

    def execute
      raise 'No execution yet'
    end
  end

  class KillCommand < Command

    def initialize(options)
      document 'kills a given process orchestrated through Orchestrator'
      super options
    end

    def execute
      raise 'Kill not implemented yet'
    end
  end

  class PSCommand < Command
    def initialize(options)
      document 'lists out the currently living processes orchestrated by Orchestrator'
      super options
    end

    def execute
      raise 'No PS command yet'
    end
  end

  class KillAllCommand < Command
    def initialize(options)
      document 'Kills all processes managed by Orchestrator'
    end

    def execute
      raise 'Kill all not implemented yet'
    end
  end

end