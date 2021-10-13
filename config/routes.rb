Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'comments/edit'
  get 'comments/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # ROOT
  root to: 'home#index'

  # LOGIN / LOGOUT
  get "/auth/google_oauth2/callback" => "sessions#create"
  delete '/logout', to: 'sessions#destroy', as: :logout

  # CATEGORY
  resources :categories do
    resources :discussions
  end

  # COMMENT
  resources :comments, only: [:create, :destroy, :edit, :update] do 
    post :preview, on: :collection
  end
end
