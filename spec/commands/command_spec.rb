require_relative '../../lib/conductor/commands/base'


describe Conductor::Command do
  describe 'instance methods' do

    let(:subject) {Conductor::Command.new}

    describe 'execution' do
      it 'raises an exception' do
        expect(lambda{subject.execute}).to raise_exception RuntimeError
      end
    end

    describe 'stringification' do
      it 'returns Command: no documentation provided for this command' do
        expect(subject.to_s).to eql 'Conductor::Command: no documentation provided for this command'
      end
    end
  end

end