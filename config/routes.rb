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
  resources :discussions, only: :destroy

  # COMMENT
  resources :comments, only: [:create, :destroy, :edit, :update] do 
    post :preview, on: :collection
  end
end
