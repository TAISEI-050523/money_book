Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#index'
  resources :incomes, only: [:new, :create, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :fixed_costs, only: [:new, :create, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :variable_costs, only: [:new, :create, :destroy]  do
    collection do
      get 'search'
    end
  end
  resources :purchase_plans, only: [:index, :new, :create, :destroy]
  resources :budgets, only: [:index, :new, :create, :edit, :update]
end
