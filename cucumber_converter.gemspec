Gem::Specification.new do |s|
  s.name        = 'cucumber_converter'
  s.version     = '0.0.1'
  s.date        = '2017-07-28'
  s.summary     = "Converts cucumber tests to Rspec Features"
  s.description = "Converts cucumber tests to Rspec Features"
  s.authors = 'Tracy Meade'
  s.email = 'meade.tracy@gmail.com'
  s.files = `git ls-files -- lib/*`.split("\n")
  s.executables << 'cucumber_convert'
end
