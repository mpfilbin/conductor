require_relative '../../lib/conductor/logging/file_logger'

describe FileLogger do
  let (:options) {stub('options', logging_path: '/var/log', stack_name: 'my_stack')}

  it 'opens a file to log to' do
    File.expects(:open).once.with('/var/log/my_stack.log', File::APPEND)
    FileLogger.new(options)
  end

end