class Feature
  attr_accessor :gherkin, :step_data
  def initialize(gherkin, step_data)
    @gherkin = gherkin
    @step_data = step_data
  end

  def feature_name
    @feature_name ||= gherkin[:feature][:name]
  end

  def feature_tags
    tag_parser.format_tags(gherkin[:feature][:tags])
  end

  def tag_parser
    @tag_parser ||= TagParser.new
  end

  def to_s
<<-EOT
feature \"#{feature_name}\"#{feature_tags} do
#{background.to_s}
#{scenarios.map(&:to_s).join("\n")}
end
EOT
  end

  def scenarios
    @scenarios ||= gherkin[:feature][:children].select { |child|
      child[:type] == :Scenario
    }.map{|child| Scenario.new(child, step_data) }
  end

  def background
    @background ||= gherkin[:feature][:children].select { |child|
      child[:type] == :Background
    }.map{|child| Background.new(child, step_data) }.first
  end
end
