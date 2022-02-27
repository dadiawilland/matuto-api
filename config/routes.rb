Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  namespace :api do
    resources :users
    resources :partners
    namespace :onboarding do
      get 'survey', action: :index, controller: 'onboarding_surveys'
      get 'survey/:id', action: :show, controller: 'onboarding_surveys'
      put 'survey/:id', action: :update, controller: 'onboarding_surveys'
      post 'survey', action: :batch_create, controller: 'onboarding_surveys'
      post 'answers', action: :post_answers, controllers: 'onboarding_answers'
    end
  end
end
