$:.push File.expand_path("../lib", __FILE__)

# Maintain your s.add_dependency's version:
require "lowmac/version"

# Describe your s.add_dependency and declare its dependencies:
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

  # Running active jobs
  s.add_dependency "delayed_job_mongoid"
  
  # Cancan
  s.add_dependency "cancancan"
  
  
  s.add_dependency 'coffee-rails', '~> 4.1.0'

  # Rails Fontawesome support
  s.add_dependency 'font-awesome-rails'

  # FullCalendar js by Adam Shaw - http://arshaw.com/fullcalendar/
  s.add_dependency 'fullcalendar-rails'

  # For checkboxes & radioboxes with Adminlte
  s.add_dependency 'icheck-rails'

  # Ion icons 
  s.add_dependency 'ionicons-rails'

  # Use jQuery as the JavaScript library
  s.add_dependency 'jquery-rails'

  # Used by Adminlte theme on calendar page
  s.add_dependency 'jquery-ui-rails'

  s.add_dependency 'jquery-datatables-rails', '~> 3.1.1'

  # This makes links to work as per earlier.
  s.add_dependency 'jquery-turbolinks'

  # Bootstrap
  s.add_dependency 'less-rails-bootstrap'

  # Dependency for fullCalendar s.add_dependency
  s.add_dependency 'momentjs-rails'

  # Use SCSS for stylesheets
  s.add_dependency 'sass-rails', '~> 5.0'

  # Slim Templates
  s.add_dependency 'slim-rails'

  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  s.add_dependency 'turbolinks'

  # s.require_path = 'lib'

end
