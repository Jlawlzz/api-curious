Rails.application.routes.draw do

  get '/', to: 'home#index'
  get '/callback', to: 'sessions#create'


  post '/search', to: 'services#search'
  post '/add_to_playlist', to: 'services#add_to_playlist'

  get '/auth/:provider/callback', to: 'sessions#create'
  resources :services, only: [:new]
  resources :sessions, only: [:new]
  resources :users, only: [:show]
end
