class Scenario
  include StepContainer

  attr_accessor :name

  def initialize(gherkin, step_data)
    @name = gherkin[:name]
    @steps = gherkin[:steps] || []
    @tags = gherkin[:tags]
    @step_data = step_data
  end

  private

  def scenario_tags
    tag_parser.format_tags(@tags)
  end

  def template_path
    File.expand_path('./templates/scenario.erb', GEM_PATH)
  end
end
