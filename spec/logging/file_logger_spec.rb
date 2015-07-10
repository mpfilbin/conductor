require_relative '../../lib/conductor/logging/file_logger'

include Conductor::Logging

describe FileLogger do
  let (:options) {stub('options', logging_path: '/var/log', stack_name: 'my_stack')}

  it 'opens a file to log to' do
    File.expects(:open).once.with('/var/log/my_stack.log', File::APPEND)
    FileLogger.new(options)
  end

  describe 'logging info' do
    before :each do
      File.expects(:open).once.with('/var/log/my_stack.log', File::APPEND)
    end

    it 'returns a truthy value' do
      logger = FileLogger.new(options)
      expect(logger.info(123, 'ls', '...')).to be_truthy
    end
  end

  describe 'logging error' do
    before :each do
      File.expects(:open).once.with('/var/log/my_stack.log', File::APPEND)
    end

    it 'returns a truthy value' do
      logger = FileLogger.new(options)
      expect(logger.error(123, 'ls', '...')).to be_truthy
    end
  end

end