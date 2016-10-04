Rails.application.routes.draw do
  root 'static_pages#index'

  devise_for :users, path_names:  { sign_in: "login", sign_out: "logout" },
                     controllers: {
                                    registrations: "user/registrations"
                                  }
  resources :users, only: [:index, :show, :destroy]
  # devise_for :users

  resources :dealerships
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
