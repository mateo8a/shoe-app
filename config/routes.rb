Rails.application.routes.draw do
  resources :organizations, only: [:index, :show, :new, :edit, :create, :update]
  resources :shoes, only: [:index, :show, :new, :edit, :create, :update]
  devise_for :users
  resources :users, only: [:index, :show, :update, :edit]
  resources :product_types, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shoes#new'
end
