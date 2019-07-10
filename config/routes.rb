Rails.application.routes.draw do
  resources :organizations
  resources :shoes
  devise_for :users
  resources :users, only: [:index, :show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shoes#new'
end
