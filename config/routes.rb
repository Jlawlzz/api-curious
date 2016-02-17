Rails.application.routes.draw do

  get '/', to: 'home#index'
  get '/callback', to: 'services#create'
  resources :services, only: [:new]
  resources :users, only: [:show]
end
