
describe KillCommand do

  before :example do
    @process_manager = ProcessManager.new

    @double1 = double('process', id: '123')
    @double2 = double('process', id: '456')

    @process_manager << @double1
    @process_manager << @double2

    @options = double('options', command: 'kill', argv: %w(kill 456))
  end

  it 'kills the process with a matching PID' do
    expect(@process_manager).to receive(:find).with('456').and_call_original
    expect(@double2).to receive(:kill).once

    KillCommand.new(@options, @process_manager).execute
  end

end