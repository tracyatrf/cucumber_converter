class Scenario
  attr_accessor :name, :steps, :step_data
  def initialize(gherkin, step_data)
    @name = gherkin[:name]
    @steps = gherkin[:steps] || []
    @tags = gherkin[:tags]
    @step_data = step_data
  end

  def scenario_tags
    tag_parser.format_tags(@tags)
  end

  def tag_parser
    @tag_parser ||= TagParser.new
  end

  def step_converter
    @step_converter ||= StepConverter.new
  end
  
  def parse_step(step)
    step_converter.convert(step[:text], step_data)
  end

  def to_s
<<-EOT
  scenario \"#{name}\"#{scenario_tags} do
#{steps.map{|step| parse_step(step) }.map{|s| "    %s" % s}.join("\n")}
  end
EOT
  end
end
