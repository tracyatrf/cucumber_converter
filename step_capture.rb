class StepCapturer
  attr_accessor :step_definitions

  def initialize
    @step_definitions = []
  end

  def capture!(regex, &block)
    step_definitions << StepDefinition.new(regex, &block)
  end

  def post_process!
    @step_definitions = step_definitions.map do |step|
      step.process!(step_definitions) 
    end
  end
end
