module Conductor
  class ApplicationInterface
    attr_reader :home, :params, :init

    def initialize(configuration)
      @home = configuration[:home]
      @params = configuration[:params]
      @init = configuration[:start]
    end
  end
end