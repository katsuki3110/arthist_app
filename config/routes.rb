Rails.application.routes.draw do

  root 'home#top'

  resources :arthists
  resources :sings,    only:[:index]
  resources :sessions, only:[:new, :create, :destroy]
  resources :users,    only:[:new, :create]

end
