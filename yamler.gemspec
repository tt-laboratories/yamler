# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "yamler"
  s.version     = "0.0.2"
  s.authors     = ["Toptranslation Tech"]
  s.email       = ["tech@toptranslation.com"]
  s.homepage    = "https://www.toptranslation.com"
  s.summary     = "Builds i18n yaml files"
  s.description = "Builds i18n yaml files"
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "README.md"]

  s.add_development_dependency "rspec", '~> 3.5'
  s.add_development_dependency "rspec-mocks", '~> 3.5'
end
