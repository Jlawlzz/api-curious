Rails.application.routes.draw do

  get '/', to: 'home#index'
  get '/callback', to: 'sessions#create'


  post '/search', to: 'services#search'

  post '/add_to_queue', to: 'players#add_to_queue'
  post '/play_song', to: 'players#play_song'
  post '/next_song', to: 'players#next_song'
  post '/prev_song', to: 'players#prev_song'
  post '/clear_queue', to: 'players#clear_queue'

  get '/auth/:provider/callback', to: 'sessions#create'
  resources :services, only: [:new]
  resources :sessions, only: [:new]
  resources :users, only: [:show]
end
