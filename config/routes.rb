Rails.application.routes.draw do
  root to: "dashboard#index"

  scope(path_names: { new: "novo", edit: "editar" }) do
    resources :attendances, except: :destroy, path: "atendimentos" do
      post "iniciar", as: "start", action: "start", on: :member
      post "encerrar", as: "stop", action: "stop", on: :member
      post "cancelar", as: "cancel", action: "cancel", on: :member
      post "iniciar-tratamento", as: "start_item", action: "start_item", on: :member
      post "encerrar-tratamento", as: "stop_item", action: "stop_item", on: :member
    end
    resources :dashboard, only: :index, path: "painel"
    resources :customers, except: :destroy, path: "clientes"
    resources :services, except: :destroy, path: "tratamentos"
    resources :users, except: :destroy, path: "usuarios"
  end

  get '/acessar', to: 'sessions#new', as: 'login'
  post '/acessar', to: 'sessions#create', as: 'create_login'
  delete '/sair', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
