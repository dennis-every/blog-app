Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy], shallow: true do
      resources :comments, only: [:new, :create], shallow: true
      resources :likes, only: [:create, :destroy], shallow: true
    end
  end
  root 'users#index'
end
