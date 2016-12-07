Rails.application.routes.draw do
  root to: "dashboard#index"

  scope(path_names: { new: "novo", edit: "editar" }) do
    resources :attendances, except: :destroy, path: "atendimento"
    resources :dashboard, only: :index, path: "painel"
    resources :customers, except: :destroy, path: "clientes"
    resources :services, except: :destroy, path: "tratamentos"
    resources :users, except: :destroy, path: "usuarios"
  end

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
