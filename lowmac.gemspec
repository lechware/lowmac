$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lowmac/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lowmac"
  s.version     = Lowmac::VERSION
  s.authors     = ["Gaurav Cheema"]
  s.email       = ["gcheema@tecfoundary.com"]
  s.homepage    = "https://github.com/tecfoundary/hicube"
  s.summary     = "Base"
  s.description = "Base"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  # Security
  s.add_dependency "devise"

  # Google Analytics
  s.add_dependency "google-analytics-rails"

  # Mongoid
  s.add_dependency "mongoid"

  # For migrations
  s.add_dependency "mongoid_rails_migrations"

  # Cancan
  s.add_dependency "cancancan"
  
  # s.require_path = 'lib'

end
