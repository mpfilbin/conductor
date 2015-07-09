require_relative '../../lib/conductor/commands/ps_command'
require_relative '../../lib/conductor/kernel/process_manager'
require_relative '../../lib/conductor/parsers/options_parser'

include Conductor::Kernel
include Conductor::Parsers
include Conductor::Commands

describe PSCommand do
  before :example do
    @process_manager = ProcessManager.new
    @options = OptionsParser.new([])
    @subject = PSCommand.new(@options, @process_manager)

    @double1 = double('process', id: '123', spawn: nil, cmd: :pwd)
    @double2 = double('process', id: '124', spawn: nil, cmd: :ls)
    @process_manager << @double1
    @process_manager << @double2
  end


  it 'it lists PID and command for each process in the manager' do
    allow_any_instance_of(Kernel).to receive(:puts).with('123 : pwd')
    allow_any_instance_of(Kernel).to receive(:puts).with('124 : ls')
    expect(@double1).to receive(:id).once
    expect(@double1).to receive(:cmd).once
    expect(@double2).to receive(:cmd).once

    @subject.execute
  end

  it 'writes to STDOUT' do
    expect_any_instance_of(Kernel).to receive(:puts).with('123 : pwd')
    expect_any_instance_of(Kernel).to receive(:puts).with('124 : ls')

    @subject.execute
  end

end