require_relative '../../lib/conductor/applications/stack'
require_relative '../../lib/conductor/applications/interface'

include Conductor::Applications

describe Stack do
  let (:interfaces) do
    [
        {
            start: 'cmd'
        },
        {
            home: '/usr/local/bin',
            start: 'tail',
            params: [
                '-n 20',
                '/var/log/nginx.log'
            ]
        }
    ]
  end

  let(:subject) { Stack.new(interfaces) }


  it 'represents a collection of application interfaces' do
    expect(subject.applications).to all(be_instance_of Interface)
  end


  it 'is enumerable' do
    Enumerable.instance_methods.each do |method|
      expect(subject).to respond_to method
    end
  end

  describe 'enumeration' do
    describe 'when passed a block' do
      let(:block) {lambda {|item|}}
      it 'invokes that block for each item in the collection' do
        block.expects(:call).at_least(2)
        subject.each(&block)
      end
    end
  end
end