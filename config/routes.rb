Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # ROOT
  root to: 'home#index'

  # LOGIN / LOGOUT
  get "/auth/google_oauth2/callback" => "sessions#create"
  delete '/logout', to: 'sessions#destroy', as: :logout
end
