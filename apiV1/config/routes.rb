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

  get '/products/list', to: 'api/v1/requests/tables/products_manager/products#products_list'
  post '/products/product', to: 'api/v1/requests/tables/products_manager/products#product_information'
  post '/products/product/new', to: 'api/v1/requests/tables/products_manager/products#new_product'
  post '/products/product/update', to: 'api/v1/requests/tables/products_manager/products#update_product'
  post '/products/product/delete', to: 'api/v1/requests/tables/products_manager/products#delete_product'

  get '/users/list', to: 'api/v1/requests/tables/users_manager/users#users_list'
  post '/users/user', to: 'api/v1/requests/tables/users_manager/users#user_information'
  post '/users/user/new', to: 'api/v1/requests/tables/users_manager/users#new_user'
  post '/users/user/update', to: 'api/v1/requests/tables/users_manager/users#update_user'
  post '/users/user/delete', to: 'api/v1/requests/tables/users_manager/users#delete_user'



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
