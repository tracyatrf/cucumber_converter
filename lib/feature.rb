class Feature
  include StepContainer

  attr_accessor :gherkin

  class << self
    def parse_features(feature_files, parser, steps)
      feature_files.each_with_object({}) do |filename, memo|
        gherkin_document = parser.parse(File.read(filename))
        memo[new_filename(filename)] = new(gherkin_document, steps)
      end
    end

    def new_filename(filename)
      FileWriter
       .write_path(Config.feature_path_base, "cucumber_to_rspec/features/", WD, filename)
       .gsub('.feature', '.rb')
    end
  end

  def initialize(gherkin, step_data)
    @gherkin = gherkin
    @step_data = step_data
  end

  private

  def feature_name
    @feature_name ||= gherkin[:feature][:name]
  end

  def feature_tags
    tag_parser.format_tags(gherkin[:feature][:tags])
  end

  def scenarios
    @scenarios ||= gherkin[:feature][:children].select { |child|
      child[:type] == :Scenario
    }.map{ |child| Scenario.new(child, step_data) }
  end

  def background
    @background ||= gherkin[:feature][:children].select { |child|
      child[:type] == :Background
    }.map{ |child| Background.new(child, step_data) }.first
  end

  def template_path
    File.expand_path('./templates/feature.erb', GEM_PATH)
  end
end
