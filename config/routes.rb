Rails.application.routes.draw do
  
  devise_for :users
  resources :clothes
  # get 'home/index'
  get 'home/about'
  # root 'home#index'
  root 'clothes#index'
  get 'randomize/randomize'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
