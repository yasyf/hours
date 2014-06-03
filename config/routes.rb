Hours::Application.routes.draw do
  resources :entries

  root 'home#index'

end
