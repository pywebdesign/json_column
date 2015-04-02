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
  s.summary     = "A simple Json column with validation for rails and PostgreSQL Json/Jsonb field"
  s.description = "JsonColumn is a simple HashWithIndifferentAccess with a ._schema method. It makes it easier to deal with json, jsonb postgresql column. It provide validation with josn-schema"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "json-schema", "~> 2.5.0"

  s.add_development_dependency "pg"
  s.add_development_dependency "pry-rails"

end
