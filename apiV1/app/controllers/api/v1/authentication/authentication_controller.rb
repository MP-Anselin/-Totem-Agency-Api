class Api::V1::Authentication::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  @@BASE_URI = 'https://totem2-f3e2e.firebaseio.com/'
  @@PRIVATE_KEY_JSON_STRING = File.open('app/controllers/api/v1/resources/totem2-f3e2e-firebase-adminsdk-lfqcp-3e7ed4ba43.json').read

  # POST /authenticate
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    firestore_manager = Api::V1::FirebaseRequests::FirestoreManager.new

    if command.success?
      render json: {auth_token: command.result}
    else
      render json: {error: command.errors}, status: :unauthorized
    end
  end
end