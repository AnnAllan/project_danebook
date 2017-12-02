Rails.application.routes.draw do
  root 'users#new'

  resources :users, only: [:new, :create, :show, :update] do
    resource :profile, only: [:create, :show, :edit, :update]
    resources :posts, only: [:index, :create, :destroy]
    resources :photos, only: [:index, :show, :new, :create, :destroy]
  end

  resources :comments, only: [:create, :destroy]

  resource  :session, :only => [:create, :destroy]

  resources :friendings, only: [:create, :destroy, :index]

  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'
  post 'like' => 'likes#create'
  delete 'unlike' => 'likes#destroy'
  get '*path' => redirect('/')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
