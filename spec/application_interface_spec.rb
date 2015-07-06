require_relative '../lib/conductor/cli/application_interface'

describe Conductor::ApplicationInterface do

  let(:valid_options) do
    {
        home: '/foo/biz/baz',
        start: 'cmd',
        params: %w(-v -r --force)
    }
  end

  let(:invalid_options) do
    {
        home: '/foo/biz/baz',
        params: %w(-v -r --force)
    }
  end

  let(:valid_options_without_home) { valid_options.reject { |key| key == :home } }

  describe 'stringification' do
    describe 'when a start command is not defined' do
      it 'raises a runtime exception' do
        expect(lambda { Conductor::ApplicationInterface.new(invalid_options) }).to raise_error RuntimeError
      end
    end

    describe 'with multiple parameters' do
      let(:subject) do
        Conductor::ApplicationInterface.new(valid_options)
      end

      describe 'when stringified' do
        it 'contains all of the options' do
          expect(subject.to_s).to eql '/foo/biz/baz/cmd -v -r --force'
        end
      end
    end

    describe 'when a home path is not given' do
      let(:subject) { Conductor::ApplicationInterface.new(valid_options_without_home) }

      it 'does not include it in the result' do
        expect(subject.to_s).to eql('cmd -v -r --force')
      end
    end
  end


end