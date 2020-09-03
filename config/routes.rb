Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "goods#index"
  resources :goods, only: [:index, :new, :create, :show] do
    resources :buys, only: [:index, :create]
    collection do
      get 'profit_calc'
    end
  end
end
