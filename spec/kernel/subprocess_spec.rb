require 'open3'
require_relative '../../lib/conductor/kernel/subprocess'
include Conductor::Kernel

describe Subprocess do

  describe 'instantiation' do
    it 'creates a Ruby subprocess for the provided command' do
      expect(Open3).to receive(:popen3).with('cmd')
      Subprocess.new('cmd')
    end

    describe 'when passed a block' do
      subject {lambda{|stdin, stout, stderr, thread|}}

      it 'calls the block with STDIN, STDOUT STDERR and the thread' do
        expect(subject).to receive(:call).at_least(:once)
        Subprocess.new('ls', &subject)
      end
    end

    it 'creates a new application thread for STDOUT and STDERR' do
      expect(Thread).to receive(:new).exactly(2).times
      Subprocess.new('ls')
    end

  end


end