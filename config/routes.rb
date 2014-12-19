Rails.application.routes.draw do

  devise_for :users
  
  get '/users/events', to: 'users#events'
  resources :users, :only => [:index, :show, :edit, :update] do
    member do
      get :status
    end
  end

  root :to => "users#index"

end
