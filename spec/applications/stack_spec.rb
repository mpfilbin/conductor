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

end