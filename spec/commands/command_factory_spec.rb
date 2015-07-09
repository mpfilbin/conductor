require_relative '../../lib/conductor/commands/command_factory'

include Conductor::Commands

describe CommandFactory do
  describe 'instantiating a new OrchestrateCommand' do
    it 'instantiates it with a set of options and an instance of process monitor' do
      options = double(command: :orchestrate, stack_name: 'my_sack', config_path: '', logging_path:'')
      process_mon = double('process_monitor')

      expect(YAML).to receive(:load_file)
      expect(ProcessManager).to receive(:new).and_return(process_mon)
      expect(OrchestrateCommand).to receive(:new).with(options, process_mon).and_call_original
      expect(File).to receive(:open).once

      factory_instance = CommandFactory.new
      instance = factory_instance.instantiate(options)
      expect(instance).to be_instance_of OrchestrateCommand
    end
  end

  describe 'instantiating a new PSCommand' do
    it 'instantiates it with a set of options and an instance of process monitor' do
      options = double(command: :ps, argv: [], config_path: '')
      process_mon = double('process_monitor')

      expect(ProcessManager).to receive(:new).and_return(process_mon)
      expect(PSCommand).to receive(:new).with(options, process_mon).and_call_original

      factory_instance = CommandFactory.new
      instance = factory_instance.instantiate(options)
      expect(instance).to be_instance_of PSCommand
    end
  end

  describe 'instantiating a new KillCommand' do
    it 'instantiates it with a set of options and an instance of process monitor' do
      options = double(command: :kill, argv: [], config_path: '')
      process_mon = double('process_monitor')

      expect(ProcessManager).to receive(:new).and_return(process_mon)
      expect(KillCommand).to receive(:new).with(options, process_mon).and_call_original

      factory_instance = CommandFactory.new
      instance = factory_instance.instantiate(options)
      expect(instance).to be_instance_of KillCommand
    end
  end

  describe 'instantiating a new KillAllCommand' do
    it 'instantiates it with a set of options and an instance of process monitor' do
      options = double(command: :kill_all, argv: [], config_path: '')
      process_mon = double('process_monitor')

      expect(ProcessManager).to receive(:new).and_return(process_mon)
      expect(KillAllCommand).to receive(:new).with(options, process_mon).and_call_original

      factory_instance = CommandFactory.new
      instance = factory_instance.instantiate(options)
      expect(instance).to be_instance_of KillAllCommand
    end
  end

end