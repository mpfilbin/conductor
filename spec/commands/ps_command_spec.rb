require_relative '../../lib/conductor/commands/ps_command'
require_relative '../../lib/conductor/kernel/process_manager'

include Conductor::Commands

describe PSCommand do
  let(:process_manager) { Conductor::Kernel::ProcessManager.new }
  let(:options) { mock('options') }
  let(:process1) { stub('process1', id: '123', cmd: 'ls') }
  let(:process2) { stub('process2', id: '456', cmd: 'pwd') }
  subject { PSCommand.new(options, process_manager) }

  before :example do
    [process1, process2].each { |process| process_manager << process }

  end


  it 'it lists PID and command for each process in the manager' do
    STDOUT.stubs(:write)

    process1.expects(:id).once
    process1.expects(:cmd).once
    process2.expects(:id).once
    process2.expects(:cmd).once

    subject.execute
  end

  it 'writes to STDOUT' do
    STDOUT.expects(:write).with('123 : ls').once
    STDOUT.expects(:write).with('456 : pwd').once

    subject.execute
  end

end