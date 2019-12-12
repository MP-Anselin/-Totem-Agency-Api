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
end
