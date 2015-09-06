$:.push File.expand_path("../lib", __FILE__)

# Maintain your s.add_dependency's version:
require "lowmac/version"

# Describe your s.add_dependency and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lowmac"
  s.version     = Lowmac::VERSION
  s.authors     = ["Gaurav Cheema"]
  s.email       = ["gcheema@tecfoundary.com"]
  s.homepage    = "https://github.com/tecfoundary/lowmac"
  s.summary     = "Base"
  s.description = "Base"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.2"

  # Single Date Picker
  s.add_dependency "bootstrap-datepicker-rails"

  # HTML5 chart library
  s.add_dependency "chart-js-rails"

  # Security
  s.add_dependency "devise"

  s.add_dependency "devise_invitable"

  # Google Analytics
  s.add_dependency "google-analytics-rails"

  s.add_dependency 'delayed_job_active_record'
  
  # For managing avatar
  s.add_dependency "carrierwave-aws"
  
  # Cancan
  s.add_dependency "cancancan"
  
  
  s.add_dependency 'coffee-rails', '~> 4.1.0'

  # FullCalendar js by Adam Shaw - http://arshaw.com/fullcalendar/
  s.add_dependency 'fullcalendar-rails'

  # For checkboxes & radioboxes with Adminlte
  s.add_dependency 'icheck-rails'

  # Ion icons 
  s.add_dependency 'ionicons-rails'

  # Use jQuery as the JavaScript library
  s.add_dependency 'jquery-rails'

  # Fileupload plugin
  s.add_dependency 'jquery-fileupload-rails'
  
  # Used by Adminlte theme on calendar page
  s.add_dependency 'jquery-ui-rails'

  s.add_dependency 'jquery-datatables-rails', '~> 3.3.0'

  # This makes links to work as per earlier.
  s.add_dependency 'jquery-turbolinks'

  # Pagination
  s.add_dependency 'kaminari'
  
  # Bootstrap
  s.add_dependency 'less-rails-bootstrap'

  # Used by Carrierwave to do image resizing
  s.add_dependency "mini_magick"

  # Dependency for fullCalendar s.add_dependency
  s.add_dependency 'momentjs-rails'

  # To show progress for page load
  s.add_dependency 'pace-rails'

  # Inline CSS for Email
  s.add_dependency 'premailer-rails'

  # Used by Premailer
  s.add_dependency 'nokogiri'

  # Use SCSS for stylesheets
  s.add_dependency 'sass-rails', '~> 5.0'

  # Slim Templates
  s.add_dependency 'slim-rails'

  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  s.add_dependency 'turbolinks'

end
