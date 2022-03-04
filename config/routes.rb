Rails.application.routes.draw do

  root    'homes#top'
  get     '/login', to: 'sessions#new'
  post    '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only:[:new, :create, :show, :edit, :update]
  resources :posts



  end
