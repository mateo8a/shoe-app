Rails.application.routes.draw do
  devise_for :users

  resources :shoes

  root 'shoes#new'
end
