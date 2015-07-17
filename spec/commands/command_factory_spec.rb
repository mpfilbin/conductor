require_relative '../../lib/conductor/commands/command_factory'
require_relative '../../lib/conductor/exceptions/invalid_command_error'

include Conductor::Commands
include Conductor::Errors

describe CommandFactory do
  let(:options) { mock('options') }
  let(:process_manager) { mock('process_monitor') }

  before :each do
    options.stubs(:stack).returns('my_stack')
    options.stubs(:config_path).returns('/home/user/.stacks/')
    options.stubs(:logging_path).returns('/var/log')
    ProcessManager.expects(:new).once.returns(process_manager)
  end

  describe 'instantiating a new OrchestrateCommand' do
    before :each do
      options.stubs(:command).returns(:orchestrate)
      YAML.expects(:load_file).once
      File.expects(:open).with('/var/log/my_stack.log', File::APPEND)
    end

    it 'instantiates it with a set of options and an instance of process monitor' do
      instance = CommandFactory.new.instantiate(options)
      expect(instance).to be_instance_of OrchestrateCommand
    end
  end

  describe 'instantiating a new PSCommand' do
    before :each do
      options.stubs(:command).returns(:ps)
    end
    it 'instantiates it with a set of options and an instance of process monitor' do
      instance =CommandFactory.new.instantiate(options)
      expect(instance).to be_instance_of PSCommand
    end
  end

  describe 'instantiating a new KillCommand' do
    before :each do
      options.stubs(:command).returns(:kill)
    end
    it 'instantiates it with a set of options and an instance of process monitor' do
      instance =CommandFactory.new.instantiate(options)
      expect(instance).to be_instance_of KillCommand
    end
  end

  describe 'instantiating a new KillAllCommand' do
    before :each do
      options.stubs(:command).returns(:kill_all)
    end
    it 'instantiates it with a set of options and an instance of process monitor' do
      instance =CommandFactory.new.instantiate(options)
      expect(instance).to be_instance_of KillAllCommand
    end
  end

  describe 'when attempting to instantiate a command that does not exist' do
    before :each do
      options.stubs(:command).returns(:i_dont_exist)
    end

    it 'raises an InvalidCommand exception' do
      expect(lambda {CommandFactory.new.instantiate(options)}).to raise_error(InvalidCommandError)
    end
  end
end