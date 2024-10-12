Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :wallets, only: [:show, :create, :update] do
        member do
          post :credit
          post :debit
          post :transfer
        end
        get :transactions, on: :member
      end
      resources :sessions, only: [:create, :destroy]
      get 'stock_prices/price', to: 'stock_prices#price'
      get 'stock_prices/prices', to: 'stock_prices#prices'
      get 'stock_prices/price_all', to: 'stock_prices#price_all'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
