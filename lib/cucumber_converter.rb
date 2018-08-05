require 'setup'

# load all step definitions to be captured
# having redifined 'Given' in the main object, loading these files in the main scope
# should call our definition, which has a reference to our step capturer to capture these calls.
Dir.glob("#{Config.step_path_base}/**/*.rb").each(&method(:load))

# Beep Boop Beep -- now we have code for step definitions
steps = step_capturer.post_process!

# Write those files!
step_definitions = StepDefinition.parse_steps(steps, Config.step_path_base)
FileWriter.write_files(step_definitions)

# convert feature files
# use gherkin parser to get an object representation of a feature file,
# and write it in rspec syntax
feature_files = Dir.glob("#{Config.feature_path_base}/**/*.feature")
features = Feature.parse_features(feature_files, Gherkin::Parser.new, steps)
FileWriter.write_files(features)
