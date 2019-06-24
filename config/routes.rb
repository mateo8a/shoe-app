Rails.application.routes.draw do
  resources :shoes
  devise_for :users, :controllers => {:registrations => "my_devise/registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shoes#new'
end
