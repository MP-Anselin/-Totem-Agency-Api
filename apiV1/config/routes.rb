Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :basic_tests
  post 'client/authentication', to: 'api/v1/authentication/authentication#authenticate'

  get '/user/account/generate', to: 'api/v1/requests/tables/users_manager/user_private_access#customer_token_generator'
  post '/user/account/signep', to: 'api/v1/requests/tables/users_manager/user_private_access#sign_ep'
  post '/user/account/delete', to: 'api/v1/requests/tables/users_manager/user_private_access#delete_user_account'


  post '/user/account/id/refresh', to: 'api/v1/requests/tables/users_manager/user_private_access#refresh_token'
  post '/user/account/id/change', to: 'api/v1/requests/tables/users_manager/user_private_access#user_change_id'

  post '/user/account/id/pwd/reset/code/mail', to: 'api/v1/requests/tables/users_manager/user_private_access#reset_pwd_send_mail'
  post '/user/account/id/pwd/reset/code/validation', to: 'api/v1/requests/tables/users_manager/user_private_access#pwd_reset_verification'

  post '/user/account/id/email/code/mail', to: 'api/v1/requests/tables/users_manager/user_private_access#mail_email_validation'
  post '/user/account/id/email/code/validation', to: 'api/v1/requests/tables/users_manager/user_private_access#email_confirmation'

  post '/user/account/data/manage', to: 'api/v1/requests/tables/users_manager/user_private_access#user_manage_data'

  get '/products/list', to: 'api/v1/requests/tables/products_manager/products#product_list'




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
