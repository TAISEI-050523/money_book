Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#index'
  resources :incomes, only: [:new, :create]
  resources :fixed_costs, only: [:new, :create]
  resources :variable_costs, only: [:new, :create]
  resources :purchase_plans, only: [:index, :new, :create, :destroy]
end
