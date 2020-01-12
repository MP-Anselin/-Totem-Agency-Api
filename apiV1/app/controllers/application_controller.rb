# main class controller
class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  require './app/controllers/api/v1/tools/macro_list'

  def initialize
    super
    @error_render = {"error": {
        "code": 500,
        "message": "INTERNAL_SERVER_ERRROR",
        "errors": [{
                       "message": "INTERNAL_SERVER_ERRROR",
                       "domain": "global",
                       "reason": "invalid"
                   }]}}

  end

  @rend_error =

      def error_rend(message, code)
        {"error": {
            "code": code,
            "message": message,
            "errors": [{
                           "message": message,
                           "domain": "global",
                           "reason": "invalid"
                       }]}}
      end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result

    render json: {error: 'Not Authorized'}, status: 401 unless @current_user
  end
end