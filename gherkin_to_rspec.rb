class GherkinToRspec
  attr_accessor :gherkin, :step_data
  def initialize(gherkin, step_data)
    @gherkin = gherkin
    @step_data = step_data
  end

  def transpile
    feature = Feature.new(gherkin, step_data)
    feature.to_s
  end
end
