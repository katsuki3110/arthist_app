Rails.application.routes.draw do

  root 'home#top'

  resources :sessions, only:[:new, :create, :destroy]
  resources :users

end
