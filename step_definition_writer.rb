class StepDefinitionWriter
  def write_step_files(steps, new_file_path)
    steps.group_by{|step| step.location}.each do |filename, steps|
      new_file_name = filename.gsub(new_file_path, File.expand_path(File.dirname(__FILE__) + "/dist/step_definitions"))
      response = FileUtils.mkdir_p(File.dirname(new_file_name))
      file_contents = [
        "module StepDefinitions\n",
        steps.map{|step| step.processed_code}.join("\n").lines.map{ |line| "  "+line }.join,
        "end\n"
      ].join
      File.open(new_file_name, 'w+') do |f| 
        f.write(file_contents)
      end
    end
  end 
end
