module StepContainer
  attr_accessor :steps, :step_data

  def to_s
    template.result(binding)
  end

  private

  def tag_parser
    @tag_parser ||= TagParser.new
  end

  def step_converter
    @step_converter ||= StepConverter.new
  end

  def parse_step(step)
    step_converter.convert(step[:text], step_data)
  end

  def parsed_steps
    steps.map(&method(:parse_step))
  end

  def template
    ERB.new(File.read(template_path), nil, '->')
  end
end
