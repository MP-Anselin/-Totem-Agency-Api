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
              set_default_curl_variable
            end

            def set_default_curl_variable
              @params = nil
              @path = nil
              @enctyp = 'application/json'
            end

            # exec curl and render on right way the answer
            def render_action
              response = @http_requests.curl_exe(@path, @params, @enctyp)
              render json: response.body, status: response.code
              set_default_curl_variable
            end

            # POST /user/id/refresh user get token
            def refresh_token
              grant_type = params[:grant_type]
              refresh_token = params[:refresh_token]

              @params = {'grant_type': grant_type, 'refresh_token': refresh_token}
              @path = FIREBASE_REFRESH_TOKEN_USER
              @enctyp = 'application/x-www-form-urlencoded'
              render_action
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

            # POST /user/id/email/code/mail send mail to check the email
            def mail_email_validation
              user_id_token = params[:idToken]
              request_type = params[:requestType]

              @params = {'requestType': request_type, 'idToken': user_id_token}
              @path = FIREBASE_EMAIL_VALIDATION_USER
              render_action
            end

            # POST /user/id/email/code/mail check the email
            def email_confirmation
              oob_code = params[:oobCode]

              @params = {'oobCode': oob_code}
              @path = FIREBASE_EMAIL_CONFIRM_USER
              render_action
            end

            # POST /user/id/pwd/reset/code/email send email to reset password user
            def reset_pwd_send_mail
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

            # POST /user/id/change change password or email of the user
            def user_change_id
              new_email = params[:email]
              new_pwd = params[:password]
              user_id_token = params[:idToken]
              change_pwd = {'idToken': user_id_token, 'password': new_pwd, "returnSecureToken": true}
              change_email = {'idToken': user_id_token, 'email': new_email, "returnSecureToken": true}

              @params = new_pwd.nil? ? change_email : change_pwd
              @path = FIREBASE_CHANGE_ID_USER
              render_action
            end

            # POST /user/data/update and /user/data/get update/get user information
            def user_manage_data
              user_id_token = params[:idToken]
              display_name = params[:displayName]
              photo_url = params[:photoUrl]
              set_info = {'idToken': user_id_token, 'displayName': display_name, 'photoUrl': photo_url, "returnSecureToken": true}
              get_info = {'idToken': user_id_token}

              @params = display_name.nil? && photo_url.nil? && !user_id_token.nil? ? get_info : set_info
              @path = FIREBASE_MANGE_INFO_USER
              render_action
            end

            # POST /user/account/delete delete user account
            def delete_user_account
              user_id_token = params[:idToken]

              @params = {'idToken': user_id_token}
              @path = FIREBASE_DELETE_ACCOUNT_USER
              render_action
            end

          end
        end
      end
    end
  end
end
