require 'fileutils'
step_path_base = "/Users/tmeade/rpace/panda/features/step_definitions/"

Dir.glob("#{step_path_base}/**/*.rb") do |filename|
  file = File.read(filename)
  newlines = file.lines.map do |line|
    match = line.match(/(?:And|When|Then|Given)\((.*)\)[\s]do[\s]?(?:\|(.*)\|)?/)
    if match
      new = (match[1].gsub(/\s/,"_").gsub(/\W|\d/,"").gsub(/_$/,"").gsub(/_+/,"_")).downcase
      new = new + ('(%s)' % match[2]) if match[2]
      line = "def #{new}\n"
    end
    line
  end
  
  new_file = filename.gsub(step_path_base, File.expand_path(File.dirname(__FILE__) + "/step_definitions")
)
  response = FileUtils.mkdir_p(File.dirname(new_file))
  File.open(new_file, 'w+') { |f| 
    f.write("module StepDefinitions\n  ")
    f.write(newlines.join("  "))  
    f.write("end\n")
  }
end

