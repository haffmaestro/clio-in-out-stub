                  Prefix Verb   URI Pattern                       Controller#Action
        new_user_session GET    /users/sign_in(.:format)          devise/sessions#new
            user_session POST   /users/sign_in(.:format)          devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)         devise/sessions#destroy
           user_password POST   /users/password(.:format)         devise/passwords#create
       new_user_password GET    /users/password/new(.:format)     devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
                         PATCH  /users/password(.:format)         devise/passwords#update
                         PUT    /users/password(.:format)         devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)           devise/registrations#cancel
       user_registration POST   /users(.:format)                  devise/registrations#create
   new_user_registration GET    /users/sign_up(.:format)          devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)             devise/registrations#edit
                         PATCH  /users(.:format)                  devise/registrations#update
                         PUT    /users(.:format)                  devise/registrations#update
                         DELETE /users(.:format)                  devise/registrations#destroy
           add_user_team POST   /teams/:id/add_user(.:format)     teams#add_user
                   teams GET    /teams(.:format)                  teams#index
                         POST   /teams(.:format)                  teams#create
                new_team GET    /teams/new(.:format)              teams#new
               edit_team GET    /teams/:id/edit(.:format)         teams#edit
                    team GET    /teams/:id(.:format)              teams#show
                         PATCH  /teams/:id(.:format)              teams#update
                         PUT    /teams/:id(.:format)              teams#update
                         DELETE /teams/:id(.:format)              teams#destroy
            events_users GET    /users/events(.:format)           users#events
  get_current_user_users GET    /users/get_current_user(.:format) users#get_current_user
                   users GET    /users(.:format)                  users#index
               edit_user GET    /users/:id/edit(.:format)         users#edit
                    user GET    /users/:id(.:format)              users#show
                         PATCH  /users/:id(.:format)              users#update
                         PUT    /users/:id(.:format)              users#update
                    root GET    /                                 users#index
