Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'} 

  namespace :users do
    resource :account
  end

  #
  # Vendor Integration Routes
  #
  namespace :webhooks do
    resource :email, only: [:create] #cloudmailin
  end

end
