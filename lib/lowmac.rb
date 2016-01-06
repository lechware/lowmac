require 'add-to-homescreen-rails'
require 'chart-js-rails'
require 'bootstrap-datepicker-rails'
require 'bootstrap-wysihtml5-rails'
require 'browser'
require 'devise'
require 'devise_invitable'
require 'delayed_job_active_record'
require 'cancancan'
require 'carrierwave-aws'
require 'coffee-rails'
require 'fullcalendar-rails'
require 'icheck-rails'
require 'ionicons-rails'
require 'jquery-rails'
require 'jquery-fileupload-rails'
require 'jquery-ui-rails'
require 'jquery-turbolinks'
require 'kaminari'
require 'less-rails-bootstrap'
require 'premailer/rails'
require 'pace/rails'
require 'momentjs-rails'
require 'sass-rails'
require 'slim-rails'
require 'turbolinks'
require "lowmac/engine"

require 'helpers/configuration'

module Lowmac

  extend Configuration

  define_setting :skin
  define_setting :layout
end
