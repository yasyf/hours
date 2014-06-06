Hours::Application.routes.draw do
  resources :entries
  resources :export, only: [:index]

  root 'home#index'

end
