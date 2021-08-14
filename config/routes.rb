Rails.application.routes.draw do
  root to: 'homes#top'

  get 'users/show'
  get 'users/edit'
  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :scenarios, only: [:new, :create, :index, :show, :edit, :update] do
    resources :scenario_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
