class StepDefinitionWriter
  attr_reader :steps, :base_path

  def initialize(steps, base_path)
    @steps = steps
    @base_path = base_path
  end

  def write_step_files
    steps_by_file.each do |filename, file_steps|
      write_file(filename, render_template(file_steps))
    end
  end

  def render_template(file_steps)
    template.result(binding)
  end

  def steps_by_file
    steps.group_by(&:location)
  end

  def new_file_path(filename)
    filename.gsub(base_path, File.expand_path(File.dirname(__FILE__) + "/dist/step_definitions"))
  end

  def write_file(filename, file_contents)
    new_file_name = new_file_path(filename)
    response = FileUtils.mkdir_p(File.dirname(new_file_name))
    File.open(new_file_name, 'w+') { |f| f.write(file_contents) }
  end

  def template
    ERB.new(File.read(template_path), nil, '->')
  end

  def template_path
    './templates/step_definitions_file.erb'
  end
end
