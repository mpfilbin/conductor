require_relative './../spec_helper'
require_relative '../../lib/conductor/cli/commands/help_command'

include Conductor::CLI::Commands

describe HelpCommand do
  it 'does things' do
    expect(true).to equal(true)
  end
end