Rails.application.routes.draw do

  resources :events
  get 'login', to: 'login#new', :as => :login
  post 'login', to: 'login#create'
  get 'logout', to: 'login#destroy', :as => :logout
  get 'events/:id/signup', to: 'events#sign_up', :as => :sign_up_event

  resources :users
  get 'welcome/index'
  get 'users/index'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
