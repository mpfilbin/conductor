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
  let(:options) { OptionsParser.parse(%w(orchestrate my_stack)) }
  let(:stack) do
    Stack.new([
                  {
                      start: 'ls'
                  },
                  {
                      start: 'echo',
                      params: [
                          'hello world'
                      ]
                  }
              ])
  end

  it 'parses the appropriate stack file' do
    expect(StackFileParser).to receive(:new).once.with('my_stack', options).and_return(stack)
    OrchestrateCommand.new(options, double)
  end

  it 'creates a subprocess for each application in the stack file' do
    expect(StackFileParser).to receive(:new).once.with('my_stack', options).and_return(stack)
    process_manager_double = double()
    expect(process_manager_double).to receive(:<<).twice
    stack.each do |application|
      expect(Subprocess).to receive(:new).with(application).and_call_original
    end

    OrchestrateCommand.new(options, process_manager_double).execute
  end

  it 'adds the processes to the Process manager' do
    process_manager = double('process_manager')
    expect(process_manager).to receive(:<<).at_least(:once)
    expect(StackFileParser).to receive(:new).once.with('my_stack', options).and_return(stack)

    OrchestrateCommand.new(options, process_manager).execute
  end

end