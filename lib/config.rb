module Configuration
  class << self
    def default_config
      {
        step_path_base: File.expand_path("features/step_definitions", WD),
        feature_path_base: File.expand_path("features", WD)
      }
    end

    def config(config_file)
      OpenStruct.new(default_config.merge(
        File.exists?(config_file) ? YAML.load_file(config_file) : {}
      ))
    end
  end
end
