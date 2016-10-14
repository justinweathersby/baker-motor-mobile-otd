Rails.application.routes.draw do
  root 'static_pages#index'

  devise_for :users, path_names:  { sign_in: "login", sign_out: "logout" },
                     controllers: {
                                    registrations: "user/registrations"
                                  }
  devise_scope :user do
    get '/users/sign_out' => 'user/sessions#destroy'
  end

  #===============Api Routes================
  require 'api_constraints'

   namespace :api, defaults: { format: :json } do
       # scope per version of api
       scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

         resources :sessions, :only      => [:create, :destroy]
         match '/login'                  => 'sessions#create', :via => [:options, :post]
         post '/logout/:user_id'         => 'sessions#destroy'

         match '/users/:id'              => 'users#update', :via => [:options, :put, :post]
        #  get '/matches'                  => 'matches#show'

         resources :users, :only         => [:show, :create, :update]
         resources :dealerships, :only   => [:index, :show]

        #  resources :messages


     end
   end
   #==========================================

  resources :users, only: [:index, :show, :destroy]
  # devise_for :users

  resources :dealerships
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
