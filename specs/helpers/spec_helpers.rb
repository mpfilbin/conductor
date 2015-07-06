module Conductor
  module Rspec
    module Helpers

      class Stub
        def initialize(opts)
          # Noop
        end
      end

      def define_class(class_name)
        class_implementation = Class.new(Stub)
        Conductor.const_set(class_name, class_implementation)
      end

      def undefine_class(klass)
        Object.send(:remove_const, klass.class.to_s)
      end
    end
  end
end