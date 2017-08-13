class Background
  attr_accessor :name, :steps, :step_data
  def initialize(gherkin, step_data)
    @steps = gherkin[:steps] || []
    @step_data = step_data
  end

  def step_converter
    @step_converter ||= StepConverter.new
  end
  
  def parse_step(step)
    step_converter.convert(step[:text], step_data)
  end

  def to_s
<<-EOT
  before(:each) do
#{steps.map{|step| parse_step(step) }.map{|s| "    %s" % s}.join("\n")}
  end
EOT
  end
end
