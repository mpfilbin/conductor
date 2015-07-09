require 'open3'
require_relative '../../lib/conductor/kernel/subprocess'
include Conductor::Kernel

describe Subprocess do

  describe 'instantiation' do
    it 'creates a Ruby subprocess for the provided command' do
      Open3.expects(:popen3).with('cmd').once
      Subprocess.new('cmd').spawn
    end

    describe 'when passed a block' do
      subject {lambda{|stdin, stout, stderr, thread|}}

      it 'calls the block with STDIN, STDOUT STDERR and the thread' do
        subject.expects(:call).at_least(1)
        Subprocess.new('ls', &subject).spawn

      end
    end

    it 'creates a new application thread for STDOUT and STDERR' do
      Thread.expects(:new).twice
      Subprocess.new('ls').spawn
    end

  end


end