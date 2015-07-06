require_relative '../lib/conductor/cli/stack_file_parser'
require_relative '../lib/conductor/cli/application_interface'
require_relative '../lib/conductor/cli/options'

describe Conductor::CLI::StackFileParser do

  describe 'loading a stack file' do
    describe 'when the file does not exist' do
      before :each do
        options = Conductor::Options.parse(['--config=Users/foo'])
        @subject = Conductor::CLI::StackFileParser.new('does_not_exist', options)
      end

      it 'raises and exception' do
        expect(lambda { @subject.parse }).to raise_error(SystemCallError)
      end
    end

    describe 'when the file does exist' do
      before :each do
        expect(YAML).to receive(:load_file).and_return([
                                                           'home' => '/',
                                                           'start' => 'pwd',
                                                           'params' => ['--verbose']
                                                       ])
        options = Conductor::Options.parse(['--config=/Users/foo'])
        @subject = Conductor::CLI::StackFileParser.new('test_stack', options)
      end

      it 'does not raise an exception' do
        expect(lambda { @subject.parse }).to_not raise_exception
      end

      it 'returns a collection of application interfaces' do
        @subject.parse.each do |command|
          expect(command).to be_instance_of Conductor::ApplicationInterface
        end
      end
    end

  end

end