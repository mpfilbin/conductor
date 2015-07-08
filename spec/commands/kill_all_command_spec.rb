
describe KillAllCommand do

  before :example do
    @process_manager = ProcessManager.new

    @double1 = double('process', id: '123')
    @double2 = double('process', id: '456')

    @process_manager << @double1
    @process_manager << @double2

    @options = double('options', argv: %w(kill_all 456))
  end

  it 'kills the process with a matching PID' do
    expect(@process_manager).to receive(:each).and_call_original
    expect(@double1).to receive(:kill).once
    expect(@double2).to receive(:kill).once

    KillAllCommand.new(@options, @process_manager).execute
  end

end