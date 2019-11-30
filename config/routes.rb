Rails.application.routes.draw do
  devise_for :users
  root 'tweets#top'
  resources :tweets, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:index, :show] 
end
