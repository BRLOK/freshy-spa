Rails.application.routes.draw do
  root to: "users#index"
  resources :users, except: :destroy, path: "usuarios"

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
