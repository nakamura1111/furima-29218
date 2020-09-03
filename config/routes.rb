Rails.application.routes.draw do
  devise_for :users
  root "goods#index"
  resources :goods, only: [:index, :new, :create, :show] do
    resources :buys, only: [:index, :create]
    collection do
      get 'profit_calc'
    end
  end
end
