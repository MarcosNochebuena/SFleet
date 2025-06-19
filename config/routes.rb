Rails.application.routes.draw do
  resources :service_orders do
    member do
      patch :status, to: 'service_orders#update_status', as: 'status'
    end
  end
  resources :maintenance_reports
  resources :vehicles do
    member do
      patch :status, to: 'vehicles#update_status', as: 'status'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
