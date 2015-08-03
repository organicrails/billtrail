Rails.application.routes.draw do
  resources :bills, :path => '' do
    resources :transactions
    resources :friends
  end
  root 'bills#index'
end
