require './app/controllers/api/v1/requests/http_requests/http_requests_manager'
module Api
  module V1
    module Requests
      module Tables
        module UsersManager
          # Class to manage private information of the user
          class UserPrivateAccessController < Api::V1::FirebaseRequests::FireDatabaseStore
            #SIGN_UP_URL = FIREBASE_SING_UP_USER + FIREBASE_API_KEY

            def initialize
              super
              @http_requests = Api::V1::Requests::HttpRequests::HttpRequestsManager.new
            end

            # POST /sign up and sign in
            def sign_up
              email = params[:email]
              password = params[:password]
              registered = params[:registered]
              id_params = {'email': email, 'password': password, 'returnSecureToken': true}
              params = !password.nil? ? id_params : {'returnSecureToken': true}
              path = registered && !password.nil? ? FIREBASE_SING_IN_USER : FIREBASE_SIGN_UP_USER
              response = @http_requests.curl_exe(path, params)
              render json: response.body, status: response.code
            end

            # POST sign in
            def sign_in
              email = params[:email]
              password = params[:password]
              response = @http_requests.curl_exe(FIREBASE_SING_IN_USER,
                                                 'email': email,
                                                 'password': password,
                                                 'returnSecureToken': true)
              render json: response.body, status: response.code
            end


          end
        end
      end
    end
  end
end
