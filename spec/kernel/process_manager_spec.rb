require_relative '../../lib/conductor/kernel/process_manager'

include Conductor::Kernel

describe ProcessManager do


  describe 'finding a process' do

    describe 'when the manager contains a process with the matching id' do
      subject { ProcessManager.new }

      before :each do
        @subprocess = stub('subprocess', id: '123')
        subject << @subprocess
      end
      it 'finds the process' do
        expect(subject.find('123')).to equal(@subprocess)
      end
    end

    describe 'when the manager contains a process with the matching id' do
      subject { ProcessManager.new }

      before :each do
        @subprocess = stub('subprocess', id: '123')
        subject << @subprocess
      end
      it 'finds the process' do
        expect(subject.find('456')).to equal(nil)
      end
    end
  end

end