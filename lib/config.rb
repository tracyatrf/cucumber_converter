require "ostruct"

module CucumberConverter
  class << self
    attr_reader :config

    @config = OpenStruct.new({
      step_path_base: "./features/step_definitions",
      feature_path_base: "./features/user"
    })

    def configure
      yield config
    end
  end
end
