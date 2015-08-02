Rails.application.routes.draw do
  resources :bills
  root 'bills#index'
end
