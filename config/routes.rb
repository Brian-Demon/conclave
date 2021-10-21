Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # ROOT
  root to: 'categories#index'

  # LOGIN / LOGOUT
  get "/auth/:provider/callback" => "sessions#create"
  delete '/logout', to: 'sessions#destroy', as: :logout

  # CATEGORY
  resources :categories do
    resources :discussions
  end

  # DISCUSSION
  resources :discussions, only: :destroy do
    post :lock, on: :member
  end

  # COMMENT
  resources :comments, only: [:create, :destroy, :edit, :update] do 
    post :preview, on: :collection
  end

  # USER ROLES PAGE
  scope "/users" do
    resources :roles, only: [:update, :index]
  end
end
