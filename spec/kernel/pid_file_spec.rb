require_relative '../../lib/conductor/kernel/pid_file'

include Conductor::Kernel

describe PIDFile do
  let(:options) { stub('options', pid_path: '/var/run') }
  let(:process) { stub('process', cmd: 'my_app') }
  let(:file_descriptor) { stub('file_descriptor', {}) }
  subject { PIDFile.new(options, process) }

  describe 'opening the instance of PIDFileWriter' do
    it 'writes the process ID to the pid fiel' do
      File.expects(:open).with('/var/run/my_app.pid', ::File::CREAT | ::File::EXCL | ::File::WRONLY).yields(file_descriptor)
      process.expects(:id).once.returns(12345)
      file_descriptor.expects(:write).with('12345')

      subject.open
    end
  end

  describe 'closing the instance of PIDFileWriter' do
    it 'checks to see if the file exists' do
      File.expects(:exists?).with('/var/run/my_app.pid').once
      subject.close
    end
    describe 'if the file exists' do
      it 'deletes the pid file' do
        File.expects(:exists?).with('/var/run/my_app.pid').once.returns(true)
        File.expects(:delete).with('/var/run/my_app.pid').once
        subject.close
      end
    end
    describe 'when the file does not exist' do
      it 'does not delete the pid file' do
        File.expects(:exists?).with('/var/run/my_app.pid').once.returns(false)
        File.expects(:delete).with('/var/run/my_app.pid').never
        subject.close
      end
    end

  end


end