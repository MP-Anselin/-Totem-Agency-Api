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

  def rendering_answer(message = nil, status_code = nil, information = nil)
    if message
      @error_render[:error][:message] = message
      @error_render[:error][:errors][0][:message] = message
      @error_render[:error][:code] = status_code
      render json: @error_render, status: status_code
    elsif !information.nil?
      render json: {data: information}, status: :ok
    else
      render status: :ok
    end
  end

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result

    @error_render[:error][:message] = 'Not Authorized'
    @error_render[:error][:errors][0][:message] = 'Not Authorized'
    @error_render[:error][:code] = 401
    render json: @error_render, status: 401 unless @current_user
  end
end