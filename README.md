CUCUMBER 2 RSPEC CONVERTER
==========================

This Gem is meant to convert cucumber tests into RSpec tests.

This project was meant to save a lot of time in converting cucumber tests to RSpec features manually. 
It attempts to maintain the readability of the cucumber tests, but we lose the regular expression matching
and end out saving a decent amount of time in test execution, and developers seem to find them a bit easier to work with.

LIMITATIONS
===========
I did not attempt to handle some of the features of cucumber that we don't use often, such as the matrix tests.
This merely handles the straightforward feature/scenario/test structure, which was easily 99% of the test suite this
was developed for.

Additionally, this makes up method names based on the regular expressions. It merely strips out characters that are illegal in method names, and then uses it as a string. The names are usually pretty good if your regular expessions aren't too fancy, but it is worth doing some cleanup and fixing grammar and nonsensical method names. For example, the cucumber expression:

`Given('I do (not )?like pie') do`

Be aware that it would write a improperly named method called:

`def i_do_not_like_pie`

Usage
=====

You should install the gem globally, as this is how it is meant to be used.
clone the repo locally and run the command:

```
gem install cucumber_converter-0.0.1.gem
```

To use this, simply navigate to the root of your project directory and run `cucumber_convert`
This will create a folder called `cucumber_to_rspec` in your directory. This will contain new RSpec features
and a lot of files that add methods into the `StepDefinitions` module.

Configuration
=============
From here, it is up to you to wire this up.
I recommend just moving the directories into your `/spec` directory, or alternatively you can customize your test runner
to use this directory.

In order to run these tests, you will need to include the step_definitions in your testrunner configuration.

Something like this ought to do the trick:

```
RSpec.configure do |config|
  config.include StepDefinitions, type: :feature
end
```

.cucumber_converter.yml
-----------------------

You may need to set some custom options, in that case, you can create a `.cucumber.yml`. Here you can set a few options

`feature_path_base` This is the directory where your features currently live. This defaults to `features/`

`step_path_base` This is the directory where your step_definitions live. This defaults to `features/step_definitions/`

`tags` This is a mapping of any cucumber tags that you need to specifcally map. For example, in cucumber where you use the tag
`@javascript` you need the RSpec feature to use `js: true`. This allows you to set some mappings. Use a hash map here.

Example:

```
---
  :feature_path_base: './cucumber_features/'
  :step_path_base: './cucumber_features/steps/'
  :tags: 
     :@javascript: 'js: true'
     :@tba: 'skip: true'
```
