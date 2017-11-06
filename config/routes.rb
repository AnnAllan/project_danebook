Rails.application.routes.draw do
  root 'users#new'

  resources :users, only: [:new, :create, :show, :update] do
    resource :profile, only: [:create, :show, :edit, :update]
    resources :posts, only: [:index, :create, :destroy]
  end

  resources :comments, only: [:create, :destroy]

  resource  :session, :only => [:create, :destroy]

  get 'login' => 'sessions#new'
  get 'signup'=> 'users#new'
  delete 'logout' => 'sessions#destroy'
  post 'like' => 'likes#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'static_pages#home'
  # get '/timeline' => "static_pages#timeline"
  # get '/friends' => "static_pages#friends"
  # get '/about' => "static_pages#about"
  # get '/photos' => "static_pages#photos"
  # get '/about_edit' => "static_pages#about_edit"
end
