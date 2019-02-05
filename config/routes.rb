Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :proxy, only: [:create]
  get '/proxy/*url', to: "proxy#show", :constraints => { url: /[\\\/\:\-_a-zA-Z0-9\.]+/ }
end
