require_relative '../command'

class OrchestrateCommand < Command
  # @param [Conductor::OptionsParser] options
  def initialize(options)
    document 'Initiates the entire orchestration routine'
    super options
  end

  def execute
    raise 'No execution yet'
  end
end
