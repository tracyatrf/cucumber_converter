require 'method_source'
class StepDefinition
  attr_accessor :regex, :block, :location, :method_name, :processed_code

  def step_converter
    @step_converter ||= StepConverter.new
  end

  def initialize(regex, &block)
    @regex = regex
    @method_name = method_name_from_regex(regex)
    @block = block
    @location = block.source_location.first
  end

  def method_name_from_regex(regex)
    regex
      .inspect[1..-2]
      .gsub(/\s/,"_")
      .gsub(/\W|\d/,"")
      .gsub(/_$/,"")
      .gsub(/_+/,"_")
      .downcase
  end

  def to_s
    template.result(binding)
  end

  def template_path
    "./templates/step_definition.erb"
  end

  def template
    ERB.new(File.read(template_path), nil, '->')
  end

  def block_source
    @block_source ||= block.source
  end

  def method_definition
    return @method_definition if @method_definition
    match = block_source.split("\n").first.match(/(?:And|When|Then|Given)\(.*\)[\s]do[\s]?(?:\|(.*)\|)?/)
    @method_definition = match ? method_name + ('(%s)' % match[1]) : method_name
  end

  def method_body
    @method_body || raise("Method not processed")
  end

  def process!(step_definitions)
    @method_body = block_source.split("\n")[1..-2].map do |line|
      step_method_call_match = line.match(/^(\s*)step "(.*)"/)
      if step_method_call_match
        step_method_call_match[1] + step_converter.convert(step_method_call_match[2], step_definitions)
      else
        line
      end
    end
    return self
  end
end
