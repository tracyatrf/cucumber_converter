GEM_PATH = File.dirname(File.expand_path(__FILE__))

require 'fileutils'
require 'erb'
require 'gherkin/parser'
require 'gherkin/pickles/compiler'
require_relative 'step_capture'
require_relative 'step_container'
require_relative 'step_definition'
require_relative 'step_definition_writer'
require_relative 'step_converter'
require_relative 'feature'
require_relative 'background'
require_relative 'scenario'
require_relative 'tag_parser'
require 'pry'

STEP_PATH_BASE = "./features/step_definitions"
FEATURE_PATH_BASE = "./features/user"
WD = `pwd`.chomp
STEP_CAPTURER = StepCapturer.new

step_files = Dir.glob("#{STEP_PATH_BASE}/**/*.rb")
feature_files = Dir.glob("#{FEATURE_PATH_BASE}/**/*.feature")

# Define Given, Then, When, And to record all step definitions.
def Given(regex, &block)
  STEP_CAPTURER.capture!(regex, &block)
end

alias :Then :Given
alias :And :Given
alias :When :Given

#load all step definitions to be captured
step_files.each(&method(:load))

# Beep Boop Beep -- now we have code for step definitions
steps = STEP_CAPTURER.post_process!
StepDefinitionWriter.new(steps, STEP_PATH_BASE).write_step_files

# convert feature files
# use gherkin parser to get an object representation of a feature file,
# and write it in rspec syntax
parser = Gherkin::Parser.new

feature_files.each do |filename|
  gherkin_document = parser.parse(File.read(filename))
  rspec_feature = Feature.new(gherkin_document, steps)

  new_file = File.expand_path(filename.gsub(FEATURE_PATH_BASE, File.expand_path("cucumber_to_rspec/features/", WD)).gsub(".feature",".rb"))

  FileUtils.mkdir_p(File.dirname(new_file))
  File.open(new_file, 'w+') do |f|
    f.write(rspec_feature)
  end
end
