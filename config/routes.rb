Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resource :dashboard, only: [:show]
  root 'static_pages#index'
  get 'demo', to: 'static_pages#demo'
  get 'team', to: 'static_pages#team'
  get 'career', to: 'static_pages#career'
  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create 
  end
  
  resources :lessons, only: [:show, :update]
  namespace :instructor do
    resources :lessons, only: [:update, :destroy]
    resources :sections, only: [:update, :destroy] do
      resources :lessons, only: [:create, :destroy]
    end
    resources :courses, only: [:new, :create, :show, :destroy, :index] do
      resources :sections, only: [:create]
    end
  end
end# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

