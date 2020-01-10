require './app/controllers/api/v1/requests/http_requests/http_requests_manager'
module Api
  module V1
    module Requests
      module Tables
        module UsersManager
          # Class to manage private information of the user
          class UserPrivateAccessController < Api::V1::FirebaseRequests::FireDatabaseStore

            def initialize
              super
              @http_requests = Api::V1::Requests::HttpRequests::HttpRequestsManager.new
              @params = nil
              @path = nil
            end

            # exec curl and render on right way the answer
            def render_action
              response = @http_requests.curl_exe(@path, @params)
              render json: response.body, status: response.code
              @params = nil
              @path = nil
            end

            # POST /sign up and sign in with email and password, allow anonymouse connection
            def sign_ep
              email = params[:email]
              password = params[:password]
              registered = params[:registered]
              id_params = {'email': email, 'password': password, 'returnSecureToken': true}

              @params = !password.nil? ? id_params : {'returnSecureToken': true}
              @path = registered && !password.nil? ? FIREBASE_SING_IN_USER : FIREBASE_SIGN_UP_USER
              render_action
            end

            # POST /user/id/pwd/reset/code/email send email to reset password user
            def reset_pwd_send_email
              email = params[:email]
              request_type = params[:requestType]

              @params = {'requestType': request_type, 'email': email}
              @path = FIREBASE_CODE_PWD_RESET_USER
              render_action
            end

            # POST /user/id/pwd/reset/code/confirmation check if password was changed
            def pwd_reset_verification
              oob_code = params[:oobCode]
              new_pwd = params[:newPassword]

              @params = new_pwd.nil? ? {'oobCode': oob_code} : {'oobCode': oob_code, 'newPassword': new_pwd}
              @path = FIREBASE_PWD_RESET_USER
              render_action
            end

          end
        end
      end
    end
  end
end
