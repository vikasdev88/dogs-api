Rails.application.routes.draw do
  root 'home#index'

  # Api routes
  namespace :api do
    namespace :v1 do
      resource :dogs, only: [] do
        get :search_breed, on: :collection
      end
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
