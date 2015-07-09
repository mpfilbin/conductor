require_relative '../../lib/conductor/logging/file_logger'

describe FileLogger do
  let (:options) {double('options', logging_path: '/var/log', stack_name: 'my_stack')}

  it 'opens a file to log to' do
    expect(File).to receive(:open).once.with('/var/log/my_stack.log', File::APPEND)
    FileLogger.new(options)
  end

end