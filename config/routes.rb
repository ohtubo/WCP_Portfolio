Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to: 'homes#top'
  
  resources :users, only: [:show,:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
