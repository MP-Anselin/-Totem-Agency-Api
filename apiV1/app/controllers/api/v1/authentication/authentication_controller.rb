module Api
  module V1
    module Authentication
      # Class authentication jwt to device who connect with api
      class AuthenticationController < ApplicationController
        skip_before_action :authenticate_request

        # POST /authenticate
        def authenticate
          command = AuthenticateUser.call(params[:email], params[:password])

          if command.success?
            render json: {auth_token: command.result}
          else
            render json: {error: command.errors}, status: :unauthorized
          end
        end
      end
    end
  end
end

