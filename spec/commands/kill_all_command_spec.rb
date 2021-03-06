require_relative '../../lib/conductor/commands/killall_command'
require_relative '../../lib/conductor/kernel/process_manager'

include Conductor::Commands
include Conductor::Kernel

describe KillAllCommand do
  let(:process_manager) { ProcessManager.new }
  let(:options) { mock('options') }
  let(:process1) { mock('process1') }
  let(:process2) { mock('process2') }

  before :example do
    process1.stubs(:id).returns('123')
    process2.stubs(:id).returns('456')
    [process1, process2].each { |process| process_manager << process }
  end

  it 'kills the process with a matching PID' do
    process1.expects(:kill).once
    process2.expects(:kill).once

    KillAllCommand.new(options, process_manager).execute
  end

end