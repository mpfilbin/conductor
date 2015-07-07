require_relative 'interface'

module Conductor
  module Applications
    # Represents a collection of application interfaces within a given application stack
    class Stack
      include Enumerable
      attr_accessor :applications

      def initialize(interfaces)
        @applications = []
        load_interfaces(interfaces)
      end

      def each(&block)
        applications.each { |application| block.call(application) }
      end

      private
      def load_interfaces(interfaces)
        interfaces.each do |interface|
          applications << Interface.new(interface)
        end
      end

    end
  end
end
