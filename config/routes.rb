Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  namespace :api do
    resources :users
    resources :partners
    post 'onboarding', action: :batch_create, controller: 'onboarding_surveys'
  end
end
