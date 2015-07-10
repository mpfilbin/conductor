require_relative '../../lib/conductor/commands/orchestrate_command'
require_relative '../../lib/conductor/parsers/stack_file_parser'
require_relative '../../lib/conductor/parsers/options_parser'
require_relative '../../lib/conductor/applications/stack'
require_relative '../../lib/conductor/kernel/subprocess'
require_relative '../../lib/conductor/kernel/pid_file'

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

  describe 'executing the command' do
    let(:stack1) { stub('stack1', {}) }
    let(:stack2) { stub('stack2', {}) }
    let(:process1) { mock('process1') }
    let(:process2) { mock('process2') }
    let(:logger) { mock('logger') }

    before :each do
      StackFileParser.stubs(:new).returns([stack1, stack2])
      FileLogger.stubs(:new)
      PIDFile.stubs(:new)
      [process1, process2].each { |proc| proc.stubs(:spawn) }
      process_manager.stubs(:<<)
    end

    it 'creates a subprocess for each application in the stack file and adds them to the process manager' do
      Subprocess.expects(:new).twice.returns(process1, process2)
      OrchestrateCommand.new(options, process_manager).execute
    end

    describe 'when stdout is received from the process' do
      before :each do
        StackFileParser.stubs(:new).returns([stack1])
        Subprocess.stubs(:new).returns(process1).yields('message', nil, 123, 'cmd')
        FileLogger.stubs(:new).returns(logger)
      end

      after :each do
        StackFileParser.unstub(:new)
        Subprocess.unstub(:new)
        FileLogger.unstub(:new)
      end

      it 'writes info to the logger' do
        logger.expects(:send).with(:info, 123, 'cmd', 'message')
        logger.expects(:send).with(:error, 123, 'cmd', nil).never
        OrchestrateCommand.new(options, process_manager).execute
      end
    end

    describe 'when stderr is received from the process' do
      before :each do
        StackFileParser.stubs(:new).returns([stack1])
        Subprocess.stubs(:new).returns(process1).yields(nil, 'message', 123, 'cmd').once
        FileLogger.stubs(:new).returns(logger)
      end
      it 'writes error to the logger' do
        logger.expects(:send).with(:error, 123, 'cmd', 'message').once
        logger.expects(:send).with(:info, 123, 'cmd', nil).never
        OrchestrateCommand.new(options, process_manager).execute
      end
    end

  end

end