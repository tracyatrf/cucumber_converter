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

  def process!(step_definitions)
    @processed_code = block.source.lines.map do |line, index|
      match = line.match(/(?:And|When|Then|Given)\((.*)\)[\s]do[\s]?(?:\|(.*)\|)?/) 
      if match
        new = method_name
        new = new + ('(%s)' % match[2]) if match[2]
        line = "def #{new}\n"
      end
      step_method_call_match = line.match(/^(\s*)step "(.*)"/)
      if step_method_call_match
        line = step_method_call_match[1] + step_converter.convert(step_method_call_match[2], step_definitions) + "\n"
      end
      line
    end.join
    self
  end
end
