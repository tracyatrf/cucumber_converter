class Background
  include StepContainer

  def initialize(gherkin, step_data)
    @steps = gherkin[:steps] || []
    @step_data = step_data
  end

  def template_path
    "./templates/background.erb"
  end
end
