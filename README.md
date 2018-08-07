CUCUMBER 2 RSPEC
================

This Gem is meant to convert cucumber tests into Rspec tests.

This project was meant to save a lot of time in converting cucumber tests to Rspec features manually. 
It attempts to maintain the readability of the cucumber tests, but we lose the regular expression matching
and end out saving a decent amount of time in test execution, and developers seem to find them a bit easier to work with.

LIMITATIONS
===========
I did not attempt to handle some of the features of cucumber that we don't use often, such as the matrix tests.
This merely handles the straightforward feature/scenario/test structure, which was easily 99% of the test suite this
was developed for.


USAGE
=====

You should install the gem globally, as this is how it is meant to be used.
clone the repo locally and run the command:

```
gem install cucumber_converter-0.0.1.gem
```

To use this, simply navigate to the root of your project directory and run `cucumber_convert`
This will create a folder called `cucumber_to_rspec` in your directory. This will contain new Rspec features
and a lot of files that add methods into the `StepDefinitions` module.

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

