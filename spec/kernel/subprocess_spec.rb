require 'open3'
require_relative '../../lib/conductor/kernel/subprocess'
include Conductor::Kernel

describe Subprocess do
  let(:pid_file_builder) { mock('lambda') }
  let(:pid_file) { stub('pid_file', open: nil) }
  let(:interface) { stub('application_interface', to_s: 'my_command') }
  let(:callback) { lambda { |stdout, stderr, pid, cmd|} }
  subject { Subprocess.new(interface, pid_file_builder, &callback) }

  describe 'spawning a process' do

    before :each do
      pid_file_builder.stubs(:call).returns(pid_file)
    end

    describe 'when the pid file exists' do
      before :each do
        pid_file.stubs(:exists?).returns(true)
      end

      it 'does not spawn a new process' do
        Open3.expects(:popen3).never
        subject.spawn
      end
    end

    describe 'when the pid file does not exist' do
      let(:stdin) { stub('stdin', {close: nil}) }
      let(:stdout) { stub('stdout', {gets: nil}) }
      let(:stderr) { stub('stderr', {gets: nil}) }
      let(:thread) { stub('thread', {join: nil, id: 123}) }

      before :each do
        pid_file.stubs(:exists?).returns(false)
      end

      it 'spawns a new process' do
        Open3.expects(:popen3).once
        subject.spawn
      end

      it 'opens the PID file' do
        Open3.stubs(:popen3).once.yields(stdin, stdout, stderr, thread)
        pid_file.expects(:open).once
        subject.spawn
      end

      it 'closes STDIN file descriptor' do
        Open3.stubs(:popen3).once.yields(stdin, stdout, stderr, thread)
        stdin.expects(:close).once
        subject.spawn
      end

      it 'joins the process thread to the main thread' do
        Open3.stubs(:popen3).once.yields(stdin, stdout, stderr, thread)
        thread.expects(:join).once
        subject.spawn
      end

      it 'spawns a new thread for both the STDOUT and STDERR streams' do
        Open3.stubs(:popen3).once.yields(stdin, stdout, stderr, thread)
        Thread.expects(:new).twice
        subject.spawn
      end

      describe 'when the backed process writes to the STDOUT stream' do
        describe 'if a block was passed to the constructor' do
          before :each do
            Thread.stubs(:new).yields
            Open3.stubs(:popen3).once.yields(stdin, stdout, stderr, thread)
            thread.stubs(:id).returns(123)
            stdout.stubs(:gets).returns('hello world', nil)
          end
          it 'calls that block with the data from STDOUT' do
            callback.expects(:call).with('hello world', nil, 123, 'my_command')
            subject.spawn
          end
        end
      end

      describe 'when the backed process writes to the STDERR stream' do
        describe 'if a block was passed to the constructor' do
          before :each do
            Thread.stubs(:new).yields
            Open3.stubs(:popen3).once.yields(stdin, stdout, stderr, thread)
            thread.stubs(:id).returns(123)
            stderr.stubs(:gets).returns('goodbye world', nil)
          end
          it 'calls that block with the data from STDERR' do
            callback.expects(:call).with(nil, 'goodbye world', 123, 'my_command')
            subject.spawn
          end
        end
      end

    end

  end

  describe 'killing a process' do
    let(:process_thread) { stub('process_thread', join: nil) }

    before :each do
      Thread.stubs(:new)
      Open3.stubs(:popen3).yields(stub('stdin', close: nil), nil, nil, process_thread)
      pid_file_builder.stubs(:call).returns(pid_file)
      pid_file.stubs(:exists?).returns(false)
      pid_file.stubs(:open)
      pid_file.stubs(:close)
      subject.spawn
    end

    it 'asks its process thread if it is alive' do
      process_thread.expects(:alive?).once
      subject.kill
    end

    describe 'when the thread is alive' do
      before :each do
        process_thread.expects(:alive?).once.returns(true)
      end
      it 'kills the process backing the thread' do
        process_thread.expects(:kill).once
        subject.kill
      end

      it 'closes the PID file for the process' do
        process_thread.stubs(:kill)
        pid_file.expects(:close).once
        subject.kill
      end

    end

    describe 'when the thread is not alive' do
      before(:each) do
        process_thread.stubs(:alive?).returns(false)
      end

      it 'does not call #kill on the process thread ' do
        process_thread.expects(:kill).never
        subject.kill
      end

      it 'does not call #close on the PID file' do
        pid_file.expects(:close).never
        subject.kill
      end

    end

  end

  describe 'asking a process if its alive' do
    subject { Subprocess.new(interface, pid_file_builder) }
    let(:process_thread) { stub('process_thread', join: nil) }
    before :each do
      Thread.stubs(:new)
      Open3.stubs(:popen3).yields(stub('stdin', close: nil), nil, nil, process_thread)
      pid_file_builder.stubs(:call).returns(pid_file)
      pid_file.stubs(:exists?).returns(false)
      pid_file.stubs(:open)
      pid_file.stubs(:close)
      subject.spawn
    end

    describe 'when the backing thread is dead' do
      before :each do
        process_thread.stubs(:alive?).returns(false)
      end
      it 'returns false' do
        expect(subject.alive?).to eql(false)
      end
    end

    describe 'when the backing thread is alive' do
      before :each do
        process_thread.stubs(:alive?).returns(true)
      end
      it 'returns true' do
        expect(subject.alive?).to eql(true)
      end
    end

  end

  describe 'asking the process for its id' do
    subject { Subprocess.new(interface, pid_file_builder) }
    let(:process_thread) { stub('process_thread', join: nil) }
    before :each do
      Thread.stubs(:new)
      Open3.stubs(:popen3).yields(stub('stdin', close: nil), nil, nil, process_thread)
      pid_file_builder.stubs(:call).returns(pid_file)
      pid_file.stubs(:exists?).returns(false)
      pid_file.stubs(:open)
      pid_file.stubs(:close)
      subject.spawn
    end

    it 'returns the id of the backing thread' do
      process_thread.expects(:pid).once.returns(1234)
      expect(subject.id).to eql(1234)
    end

  end

end