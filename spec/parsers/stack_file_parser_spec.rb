require_relative '../../lib/conductor/parsers/stack_file_parser'
require_relative '../../lib/conductor/parsers/options_parser'
require_relative '../../lib/conductor/applications/stack'

include Conductor::Parsers

describe StackFileParser do
  let(:valid_options) { OptionsParser.parse(['--config=Users/foo']) }
  let(:yaml_contents) do
    [
        :home => '/',
        :start => 'pwd',
        :params => ['--verbose']
    ]
  end

  describe 'loading an applications file' do
    describe 'when the file does not exist' do
      it 'raises and exception' do
        expect(lambda { StackFileParser.new(valid_options).parse }).to raise_error SystemCallError
      end
    end

    describe 'when the file does exist' do
      before :each do
        expect(YAML).to receive(:load_file).and_return(yaml_contents)
      end

      it 'does not raise an exception' do
        expect(lambda { StackFileParser.new(valid_options) }).to_not raise_exception
      end
    end
  end

  describe 'parsing yaml file contents' do
    before :each do
      expect(YAML).to receive(:load_file).and_return(yaml_contents)
      @subject = StackFileParser.new(valid_options).parse
    end

    it 'returns an instance of Conductor::Applications::Stack' do
      expect(@subject).to be_instance_of Conductor::Applications::Stack
    end

  end

end