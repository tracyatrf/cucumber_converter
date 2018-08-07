require 'fileutils'
require "ostruct"
require 'yaml'
require 'erb'
require 'gherkin/parser'
require 'gherkin/pickles/compiler'
require_relative 'config'
require_relative 'step_capture'
require_relative 'file_writer'
require_relative 'step_container'
require_relative 'step_definition'
require_relative 'step_converter'
require_relative 'feature'
require_relative 'background'
require_relative 'scenario'
require_relative 'tag_parser'
require 'given'

WD = `pwd`.chomp
GEM_PATH = File.dirname(File.expand_path(__FILE__))
Config = Configuration.config(File.expand_path('.cucumber_converter.yml', WD))

include GivenDefinition
set_step_capturer(StepCapturer.new)
