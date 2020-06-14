Rails.application.routes.draw do

  root 'home#top'

  resources :arthists
  resources :sings,    only:[:index, :show, :edit, :update, :destroy]
  resources :sessions, only:[:new, :create, :destroy]
  resources :users,    only:[:new, :create]

end
