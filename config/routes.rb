Rails.application.routes.draw do
  devise_for :users
  root "goods#index"
  resources :goods do
    resources :buys, only: [:index, :create]
    collection do
      get 'profit_calc'
      get 'search'
    end
  end
end
