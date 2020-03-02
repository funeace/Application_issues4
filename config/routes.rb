Rails.application.routes.draw do
  root "homes#top"
  get "home/about" => "homes#about"

  devise_for :users

  resources :books , only: [:index, :show, :edit, :create,  :update, :destroy]
  resources :users , only: [:index, :show, :edit, :update] do
    member do
      get :followings,:followers
    end
  end
  resources :relationships, only: [:create,:destroy,:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
