Rails.application.routes.draw do

  root 'home#top'

  resources :debut,    only:[:index, :update]
  resources :likes,    only:[:create, :destroy]
  resources :arthists do
    member do
      get    :edit_image
      patch  :update_image
    end
  end
  resources :sings,    only:[:index, :destroy]
  resources :sessions, only:[:new, :create, :destroy]
  resources :users,    only:[:new, :create]

end
