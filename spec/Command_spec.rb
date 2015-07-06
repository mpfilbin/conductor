require_relative 'spec_helper'
require_relative '../lib/conductor/cli/command'


describe Conductor::CLI::Command do
  describe 'instance methods' do

    let(:subject) {Conductor::CLI::Command.new}

    describe 'execution' do
      it 'raises an exception' do
        expect(lambda{subject.execute}).to raise_exception RuntimeError
      end
    end

    describe 'stringification' do
      it 'returns Command: no documentation provided for this command' do
        expect(subject.to_s).to eql 'Conductor::CLI::Command: no documentation provided for this command'
      end
    end
  end

  describe 'static methods' do
    describe 'instantiating a command instance from a string' do
      describe 'when the class exists' do
        before :each do
          @klass = define_class('PasteCommand')
        end

        it 'returns a new instance' do
          expect(Conductor::CLI::Command.build('paste', {option: true})).to be_instance_of @klass
        end

      end

      describe 'when the class does not exist' do
        it 'raises an exception' do
          expect(lambda{Conductor::CLI::Command.build('copy', {option: true})}).to raise_error InvalidCommandError
        end
      end

    end
  end

end