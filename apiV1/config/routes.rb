Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :basic_tests
  post 'client/authentication', to: 'api/v1/authentication/authentication#authenticate'
  post '/user/signep', to: 'api/v1/requests/tables/users_manager/user_private_access#sign_ep'
  post '/user/id/pwd/reset/code/email', to: 'api/v1/requests/tables/users_manager/user_private_access#reset_pwd_send_email'
  post '/user/id/pwd/reset/code/confirmation', to: 'api/v1/requests/tables/users_manager/user_private_access#pwd_reset_verification'

  namespace :api do
    namespace :v1 do
      namespace :requests do
        namespace :tables do
          namespace :users_manager do
            resources :users
          end
        end
      end
    end
  end
end
