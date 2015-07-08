require_relative '../../lib/conductor/commands/base'


describe Conductor::Command do
  describe 'instance methods' do

    let(:subject) { Conductor::Command.new }

    describe 'execution' do
      it 'raises an exception' do
        expect(lambda { subject.execute }).to raise_exception RuntimeError
      end
    end
  end

end