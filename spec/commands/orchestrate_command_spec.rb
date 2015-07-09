require_relative '../../lib/conductor/commands/orchestrate_command'
require_relative '../../lib/conductor/parsers/stack_file_parser'
require_relative '../../lib/conductor/parsers/options_parser'
require_relative '../../lib/conductor/applications/stack'
require_relative '../../lib/conductor/kernel/subprocess'

include Conductor::Commands
include Conductor::Parsers
include Conductor::Applications
include Conductor::Kernel

describe OrchestrateCommand do
  let(:options) { mock('options') }
  let(:process_manager) { mock('process_manager') }

  it 'parses the appropriate stack file' do
    FileLogger.stubs(:new)
    StackFileParser.expects(:new).with(options).once
    OrchestrateCommand.new(options, process_manager)
  end

  it 'instantiates a new FileLogger instance' do
    StackFileParser.stubs(:new)
    FileLogger.expects(:new).with(options).once
    OrchestrateCommand.new(options, process_manager)
  end

  it 'creates a subprocess for each application in the stack file and adds them to the process manager' do
    stack1 = stub('stack1', {})
    stack2= stub('stack2', {})
    process1 = stub('process1', spawn: nil)
    process2 = stub('process2', spawn: nil)

    StackFileParser.stubs(:new).returns([stack1, stack2])
    FileLogger.stubs(:new)
    Subprocess.expects(:new).returns(process1)
    Subprocess.expects(:new).returns(process2)

    process_manager.expects(:<<).with(process1).once
    process_manager.expects(:<<).with(process2).once

    OrchestrateCommand.new(options, process_manager).execute
  end

end