Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  delete '/logout', to: 'sessions#destroy', as: :logout

  # ROOT
  root to: 'home#index'

  #LOGIN
  get "/auth/google_oauth2/callback" => "sessions#create"
end
