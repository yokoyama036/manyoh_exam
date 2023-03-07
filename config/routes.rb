Rails.application.routes.draw do
  root to: 'users#new'
  namespace :admin do
    resources :users
  end
  resources :users
  resources :sessions
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
