module Conductor
  module Applications
    # Provides a an abstraction layer over the commandline interfaces for
    # applications declared in Stack files.
    class Interface
      attr_reader :home, :init

      def initialize(configuration = {})
        @home = configuration[:home]
        @params = configuration[:params] || []
        @init = configuration[:start]
      end


      def to_s
        "#{path} #{params}"
      end

      private

      def params
        @params.join(' ')
      end

      def path
        [home, init].compact.join(File::SEPARATOR)
      end

    end
  end
end