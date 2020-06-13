Rails.application.routes.draw do

  root 'home#top'

  resources :sings
  resources :sessions, only:[:new, :create, :destroy]
  resources :users,    only:[:new, :create]

end
