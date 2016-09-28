Rails.application.routes.draw do
  root 'static_pages#index'

  devise_for :admin_users, path_names:  { sign_in: "login", sign_out: "logout" },
                     controllers: {
                                    registrations: "admin_user/registrations"
                                  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
