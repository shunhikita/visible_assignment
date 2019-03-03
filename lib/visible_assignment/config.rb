module VisibleAssignment
  class << self
    def configure
      yield config
    end

    def config
      @config ||= VisibleAssignment::Config.new
    end
  end

  class Config
    include ActiveSupport::Configurable
    config_accessor :enable_instance_variables
  end
end
