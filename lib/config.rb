require "ostruct"

module CucumberConverter
  class << self
    def default_config
      OpenStruct.new({
        step_path_base: "./features/step_definitions",
        feature_path_base: "./features"
      })
    end

    def config
      @config ||= default_config
    end

    def configure
      yield config
    end
  end
end
