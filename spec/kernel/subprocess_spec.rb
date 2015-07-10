require 'open3'
require_relative '../../lib/conductor/kernel/subprocess'
include Conductor::Kernel

describe Subprocess do
  let(:pid_file_builder) { mock('lambda') }
  let(:pid_file) { mock('pid_file') }
  let(:interface) { mock('application_interface') }

  describe 'instantiation' do
    before :each do
      pid_file_builder.stubs(:call).returns(pid_file)
      pid_file.stubs(:exists?).returns(false)
      pid_file.stubs(:open)
      interface.stubs(:to_s).returns('cmd')
    end

    it 'creates a Ruby subprocess for the provided command' do
      Open3.expects(:popen3).with('cmd').once
      Subprocess.new(interface, pid_file_builder).spawn
    end

    describe 'when passed a block' do
      subject { lambda { |stdin, stout, stderr, thread|} }
      let(:stdout) { stub('stdout', {}) }
      let(:stderr) { stub('stderr', {}) }

      before :each do
        Open3.stubs(:popen3).yields(stub('stdin', close: nil), stdout, stderr, stub('thread', join: nil))
        Thread.stubs(:new).yields
      end

      it 'calls the block with STDIN, STDOUT STDERR and the thread' do
        stdout.expects(:gets).twice.returns('output', nil)
        stderr.expects(:gets).once.returns(nil)
        subject.expects(:call).at_least(1)

        Subprocess.new(interface, pid_file_builder, &subject).spawn

      end
    end
    it 'creates a new application thread for STDOUT and STDERR' do
      stdout = stub('stdout', {gets: nil})
      stderr = stub('stderr', {gets: nil})
      Open3.stubs(:popen3).yields(stub('stdin', close: nil), stdout, stderr, stub('thread', join: nil))
      Thread.stubs(:new).twice.yields

      Subprocess.new(interface, pid_file_builder).spawn
    end
  end
end