Rails.application.routes.draw do


  devise_for :users

  resources :teams
  resources :users, :only => [:index, :show, :edit, :update] do
    collection do
      get :events
    end
  end

  root :to => "users#index"

end
