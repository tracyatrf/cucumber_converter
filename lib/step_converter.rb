class StepConverter
  def convert(step_line, step_definitions)
    matched = matched_step(step_line, step_definitions)
    if matched
      arguments = matched.regex.match(step_line)[1..-1]
      "#{matched.method_name}(#{arguments.map(&:inspect).join(", ")})"
    else
      "# #{step_line} -- no method matched"
    end
  end

  def matched_step(step_line, step_definitions)
    step_definitions.find do |step_definition|
      step_definition.regex.match(step_line)
    end
  end
end
