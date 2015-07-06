require_relative 'spec_helper'

require_relative '../lib/conductor/environment'
require_relative '../lib/conductor/cli/options'
require_relative '../lib/conductor/cli/command'

describe Conductor::Options do
  before(:each) do
    ENV['HOME'] = '/Users/jack'
  end

  describe 'instantiation' do
    let(:subject) { Conductor::Options.new }

    it "defaults the config file path to the current user's home directory" do
      expect(subject.config_path).to eq('/Users/jack/.orchestration')
    end

    it "defaults the pid file to the current user's home directory" do
      expect(subject.pid_file).to eq('/Users/jack/.current_pids')
    end
  end

  describe 'parsing' do
    describe 'verbosity' do
      describe 'when the verbose option is passed' do
        let(:subject) { Conductor::Options.parse(['--verbose']) }

        it 'sets the verbose option to true' do
          expect(subject.verbose).to be_truthy
        end
      end

      describe 'when the verbose option is not passed' do
        let(:subject) { Conductor::Options.parse([]) }

        it 'sets the verbose option to false' do
          expect(subject.verbose).to be_falsey
        end
      end
    end

    describe 'setting the configuration path' do
      describe 'the -c option' do
        describe 'when passed with a value' do
          let(:subject) { Conductor::Options.parse(['-c ./foo/bar']) }

          it 'sets the configuration file path to that value' do
            expect(subject.config_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { Conductor::Options.parse(['-c']) }).to raise_exception OptionParser::MissingArgument
          end

        end
      end

      describe 'this --config= option' do
        describe 'when passed with a value' do
          let(:subject) { Conductor::Options.parse(['--config=./foo/bar']) }

          it 'sets the configuration file path to that value' do
            expect(subject.config_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { Conductor::Options.parse(['--config']) }).to raise_exception OptionParser::MissingArgument
          end

        end
      end
    end

    describe 'setting the PIDs file path' do
      describe 'the -p option' do
        describe 'when passed a value' do
          let(:subject) { Conductor::Options.parse(['-p ./foo/bar']) }

          it 'sets the pids file path to the value' do
            expect(subject.pid_file).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises an exception' do
            expect(lambda { Conductor::Options.parse(['-p']) }).to raise_exception OptionParser::MissingArgument
          end
        end
      end

      describe 'the --pids= option' do
        describe 'when passed a value' do
          let(:subject) { Conductor::Options.parse(['--pids=./foo/bar']) }

          it 'sets the PIDs file path' do
            expect(subject.pid_file).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do
          it 'raises and exception' do
            expect(lambda { Conductor::Options.parse(['--pids=']) }).to raise_exception OptionParser::InvalidArgument
          end
        end
      end
    end
  end
end
