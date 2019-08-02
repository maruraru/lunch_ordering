Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  get '/users', to: 'users#index', as: :all_users
  get '/users/:id', to: 'users#show', as: :show_user
end
