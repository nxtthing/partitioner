Gem::Specification.new do |s|
  s.name        = "partitioner"
  s.summary     = "Partitioner"
  s.version     = "0.0.1"
  s.authors     = ["Aliaksandr Yakubenka"]
  s.email       = "alexandr.yakubenko@startdatelabs.com"
  s.files       = ["lib/partitioner.rb"]
  s.license       = "MIT"
  s.add_dependency "activesupport"
  s.add_dependency "pg_party"
end
