$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "json_column/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "json_column"
  s.version     = JsonColumn::VERSION
  s.authors     = ["Pierre-Yves Mathieu"]
  s.email       = ["pywebdesign@gmail.com"]
  s.homepage    = ""
  s.summary     = "PostgreSQL json and jsonb column made easy"
  s.description = "JsonColumn is a OpenStruc-like dynamic class replacing helping using json and jsonb postgresql column type in activerecord"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "json-schema", "~> 2.5.0"

  s.add_development_dependency "activerecord_json_validator", "~> 0.5.1"
  s.add_development_dependency "pg"
  s.add_development_dependency "pry-rails"

end
