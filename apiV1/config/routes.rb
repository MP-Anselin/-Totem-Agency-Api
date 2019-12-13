Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :basic_tests
  namespace :api do
    namespace :v1 do
      namespace :authentication do
        post 'authenticate', to: 'authentication#authenticate'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :requests do
        namespace :tables do
          resources :users
          #post 'users/init', to: 'users#create'
          #get 'users/list', to: 'users#show'
        end
      end
    end
  end
end
