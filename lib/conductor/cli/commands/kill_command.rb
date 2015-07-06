require_relative '../command'

class KillCommand < Command
  # @param [Conductor::Options] options
  def initialize(options)
    document 'kills a given process orchestrated through Orchestrator'
    super options
  end

  def execute
    raise 'Kill not implemented yet'
  end
end
