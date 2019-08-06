Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
  get '/users', to: 'users#index', as: :all_users
  get '/users/:id', to: 'users#show', as: :show_user
  get '/menus/', to: 'menus#index', as: :all_days
  post '/menus', to: 'menus#create', as: :create_menu
  get '/menus/edit_current', to: 'menus#edit_current', as: :current_menu
  get '/menus/:id', to: 'menus#show', as: :show_menu
  get '/menu_items/autocomplete_menu_item_name', as: :autocomplete_menu_item_name
  delete '/menus/current/menu_items/:id', to: 'menu_items#destroy', as: :delete_menu_item
  post '/menus/current/menu_items', to: 'menu_items#create', as: :create_menu_item
end
