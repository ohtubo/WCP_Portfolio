Rails.application.routes.draw do
  root to: 'homes#top'

  get 'searches/search'

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: %i(show edit update) do
    resource :relationships, only: %i(create destroy)
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :scenario_favorites
    end
  end

  resources :scenarios, only: %i(new create index show edit update destroy) do
    resource :scenario_favorites, only: %i(create destroy)
    # get 'favorites' => 'scenario_favorites#favorites', as: 'favorites'
    resources :scenario_comments, only: %i(create destroy)
    # get 'show' => 'scenario_favorites#show', as: 'show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, format: 'json' do
    post 'articles/preview'
  end
end
