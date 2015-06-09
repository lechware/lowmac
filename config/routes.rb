Rails.application.routes.draw do
  devise_for :users

  namespace :users do
    resource :profile
  end
end
