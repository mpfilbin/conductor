require_relative '../../lib/conductor/parsers/options_parser'

include Conductor::Parsers

describe OptionsParser do
  before(:each) do
    ENV['HOME'] = '/Users/jack'
  end

  describe 'instantiation' do
    let(:subject) { OptionsParser.new }

    it "defaults the config file path to the current user's home directory" do
      expect(subject.config_path).to eq('/Users/jack/.orchestration')
    end

    it 'defaults the pid file to /var/run' do
      expect(subject.pid_path).to eq('/var/run')
    end
  end

  describe 'parsing' do
    describe 'setting the configuration path' do
      describe 'the -c option' do
        describe 'when passed with a value' do
          let(:subject) { OptionsParser.parse(['-c ./foo/bar']) }

          it 'sets the configuration file path to that value' do
            expect(subject.config_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { OptionsParser.parse(['-c']) }).to raise_exception OptionParser::MissingArgument
          end

        end
      end

      describe 'this --config= option' do
        describe 'when passed with a value' do
          let(:subject) { OptionsParser.parse(['--config=./foo/bar']) }

          it 'sets the configuration file path to that value' do
            expect(subject.config_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { OptionsParser.parse(['--config']) }).to raise_exception OptionParser::MissingArgument
          end

        end
      end
    end

    describe 'setting the PIDs file path' do
      describe 'the -p option' do
        describe 'when passed a value' do
          let(:subject) { OptionsParser.parse(['-p ./foo/bar']) }

          it 'sets the pids file path to the value' do
            expect(subject.pid_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { OptionsParser.parse(['-p']) }).to raise_exception OptionParser::MissingArgument
          end
        end
      end

      describe 'the --pids= option' do
        describe 'when passed a value' do
          let(:subject) { OptionsParser.parse(['--pids=./foo/bar']) }

          it 'sets the PIDs file path' do
            expect(subject.pid_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises and exception' do
            expect(lambda { OptionsParser.parse(['--pids=']) }).to raise_exception OptionParser::InvalidArgument
          end
        end
      end
    end

    describe 'setting the logging path' do
      describe 'the -l option' do
        describe 'when passed a value' do
          let(:subject) { OptionsParser.parse(['-l ./foo/bar']) }

          it 'sets the pids file path to the value' do
            expect(subject.logging_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { OptionsParser.parse(['-l']) }).to raise_exception OptionParser::MissingArgument
          end
        end
      end

      describe 'the --logging-path= option' do
        describe 'when passed a value' do
          let(:subject) { OptionsParser.parse(['--logging-path=./foo/bar']) }

          it 'sets the PIDs file path' do
            expect(subject.logging_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises and exception' do
            expect(lambda { OptionsParser.parse(['--logging-path=']) }).to raise_exception OptionParser::InvalidArgument
          end
        end
      end
    end
  end

  describe 'getting the primary command from ARGV' do
    let(:subject) { OptionsParser.new(['orchestrate', 'mystack', '-l /var/log']) }
    it 'returns a symbolized representation of the command' do
      expect(subject.command).to eql(:orchestrate)
    end
  end
end
