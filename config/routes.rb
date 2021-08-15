Rails.application.routes.draw do
  root to: 'homes#top'

  get 'users/show'
  get 'users/edit'
  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :scenario_favorites
    end
  end

  resources :scenarios, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :scenario_favorites, only: [:show, :create, :destroy]
    # get 'favorites' => 'scenario_favorites#favorites', as: 'favorites'
    resources :scenario_comments, only: [:create, :destroy]
    # get 'show' => 'scenario_favorites#show', as: 'show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
