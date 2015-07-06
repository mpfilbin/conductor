require_relative '../command'

class KillAllCommand < Command
  # @param [Conductor::Options] options
  def initialize(options)
    document 'Kills all processes managed by Orchestrator'
  end

  def execute
    raise NotImplementedError.new('Kill all not implemented yet')
  end
end
