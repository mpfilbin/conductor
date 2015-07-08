require_relative '../../lib/conductor/commands/command_factory'

include Conductor::Commands

describe CommandFactory do
  describe 'instantiating a new OrchestrateCommand' do
    it 'instantiates it with a set of options and an instance of process monitor' do
      options = double(command: 'orchestrate')
      process_mon = double('process_monitor')

      expect(ProcessManager).to receive(:new).and_return(process_mon)
      expect(OrchestrateCommand).to receive(:new).with(options, process_mon)

      factory_instance = CommandFactory.new
      factory_instance.instantiate(options)
    end
  end

end