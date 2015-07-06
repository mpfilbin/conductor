require_relative '../command'

class PSCommand < Command

  # @param [Conductor::Options] options
  def initialize(options)
    document 'lists out the currently living processes orchestrated by Orchestrator'
    super options
  end

  def execute
    raise 'No PS command yet'
  end
end
