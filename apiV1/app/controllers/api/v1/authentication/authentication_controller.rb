class Api::V1::Authentication::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # POST /authenticate
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: FirebaseManager.get('https://totem2-f3e2e.firebaseio.com/users_administrator/6FgDbWaK6ciQTTDcdGbz/email') }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end