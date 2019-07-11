Rails.application.routes.draw do
  resources :organizations, only: [:index, :show, :new, :edit, :create, :update]
  resources :shoes
  devise_for :users
  resources :users, only: [:index, :show, :update, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shoes#new'
end
