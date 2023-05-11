Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create], shallow: true do
      resources :comments, only: [:new, :create], shallow: true
    end
  end
  root 'users#index'
end
