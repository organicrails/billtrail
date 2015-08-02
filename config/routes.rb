Rails.application.routes.draw do
  resources :bills, :path => '' do
    resources :transactions
  end
  root 'bills#index'
end
