Rails.application.routes.draw do
  root to: "dashboard#index"
  resources :users, except: :destroy, path: "usuarios"

  resources :dashboard, only: :index, path: "painel"

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
