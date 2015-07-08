require_relative '../../lib/conductor/kernel/process_manager'

include Conductor::Kernel

describe ProcessManager do


  describe 'killing a process' do

    describe 'when the manager contains a process with the matching id' do
      subject { ProcessManager.new }

      before :each do
        subprocess = double('subprocess')
        expect(subprocess).to receive(:id).at_least(:once).and_return('123')
        expect(subprocess).to receive(:kill).once
        allow(subprocess).to receive(:spawn)
        subject << subprocess
      end
      it 'kills the process' do
        subject.kill_process('123')
      end
    end

    describe 'when the manager does not contain the process' do
      subject { ProcessManager.new }
      it 'raises and exception' do
        expect(lambda { subject.kill_process('546') }).to raise_exception RuntimeError
      end
    end
  end

end