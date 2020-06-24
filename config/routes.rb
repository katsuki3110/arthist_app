Rails.application.routes.draw do

  root 'home#top'

  resources :likes,    only:[:create, :destroy]
  resources :arthists do
    member do
      get    :edit_image
      post   :debut_create
      patch  :update_image
      delete :debut_destroy
    end
  end
  resources :sings,    only:[:index, :destroy]
  resources :sessions, only:[:new, :create, :destroy]
  resources :users,    only:[:new, :create]

end
