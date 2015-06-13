Rails.application.routes.draw do
  devise_for :users

  namespace :users do
    resource :profile
  end

  #
  # Vendor Integration Routes
  #
  namespace :webhooks do
    resource :email, only: [:create] #cloudmailin
  end

end
