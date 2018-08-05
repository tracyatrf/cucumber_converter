module GivenDefinition
  # Define Given, Then, When, And to record all step definitions.

  attr_reader :step_capturer

  def set_step_capturer(step_capturer)
    @step_capturer = step_capturer
  end

  def Given(regex, &block)
    step_capturer.capture!(regex, &block)
  end

  alias Then Given
  alias And Given
  alias When Given
end
