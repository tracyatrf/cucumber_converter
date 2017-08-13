require 'fileutils'
require 'gherkin/parser'
require 'gherkin/pickles/compiler'
require_relative 'gherkin_to_rspec.rb'
require_relative 'step_capture'
require_relative 'step_definition'
require_relative 'step_definition_writer'
require_relative 'step_converter'
require_relative 'feature'
require_relative 'background'
require_relative 'scenario'
require_relative 'tag_parser'

STEP_PATH_BASE = "/Users/tmeade/rpace/panda/features/step_definitions"
FEATURE_PATH_BASE = "/Users/tmeade/rpace/panda/features/user"
STEP_CAPTURER = StepCapturer.new

# Define Given, Then, When, And to record all step definitions.
def Given(regex, &block)
  STEP_CAPTURER.capture!(regex, &block)
end

alias :Then :Given
alias :And :Given
alias :When :Given

#load all step definitions to be captured
Dir.glob("#{STEP_PATH_BASE}/**/*.rb"){ |filename| load filename }

# Beep Boop Beep -- now we have code for step definitions 
steps = STEP_CAPTURER.post_process!
StepDefinitionWriter.new.write_step_files(steps, STEP_PATH_BASE)

# convert feature files
# use gherkin parser to get an object representation of a feature file, 
# and write it in rspec syntax
parser = Gherkin::Parser.new

Dir.glob("#{FEATURE_PATH_BASE}/**/*.feature") do |filename|
  gherkin_document = parser.parse(File.read(filename))

  rspec_feature = GherkinToRspec.new(gherkin_document, steps).transpile
  new_file = filename.gsub(FEATURE_PATH_BASE, File.expand_path(File.dirname(__FILE__) + "/dist/features/")).gsub(".feature",".rb")

  FileUtils.mkdir_p(File.dirname(new_file))
  File.open(new_file, 'w+') do |f|
    f.write(rspec_features)
  end
end
