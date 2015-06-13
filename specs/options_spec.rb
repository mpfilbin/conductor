require_relative 'spec_helper'

require_relative '../lib/conductor/cli/options'
require_relative '../lib/conductor/cli/command'

describe Conductor::Options do
  before(:each) do
    ENV.expects(:[]).at_least_once.with('HOME').returns('/Users/jack')
  end

  after :each do
    ENV.unstub(:[])
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
            expect(lambda { Conductor::Options.parse(['-c']) }).to raise_exception
          end

        end
      end

      describe 'this --config option' do
        describe 'when passed with a value' do
          let(:subject) { Conductor::Options.parse(['--config ./foo/bar']) }

          it 'sets the configuration file path to that value' do
            expect(subject.config_path).to eql('./foo/bar')
          end
        end

        describe 'when not passed a value' do

          it 'raises an exception' do
            expect(lambda { Conductor::Options.parse(['--config']) }).to raise_exception
          end

        end
      end

    end

  end

end
