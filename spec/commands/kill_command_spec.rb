require_relative '../../lib/conductor/commands/kill_command'
require_relative '../../lib/conductor/kernel/process_manager'

include Conductor::Commands
include Conductor::Kernel

describe KillCommand do
  let(:process_manager) { ProcessManager.new }
  let(:options) { mock('options') }
  let(:process1) { mock('process1') }
  let(:process2) { mock('process2') }

  before :example do
    process1.expects(:id).once.returns('123')
    process2.expects(:id).once.returns('456')
    [process1, process2].each { |process| process_manager << process }
    options.expects(:argv).returns(%w(kill 456))
  end

  it 'kills the process with a matching PID' do
    process2.expects(:kill).once
    KillCommand.new(options, process_manager).execute
  end

end