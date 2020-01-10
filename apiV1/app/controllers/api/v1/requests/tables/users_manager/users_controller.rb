module Api
  module V1
    module Requests
      module Tables
        module UsersManager
          # Class to manage (create, sign in, sign up, sign out)
          # the user in Firebase
          class UsersController < Api::V1::FirebaseRequests::FireDatabaseStore
            require 'net/http'
            before_action only: %I[show update destroy]

            def initialize
              super

              @db_users = @firestore.col 'users'
              @information = []
              @error_info = {status: 500, error: 'Internal Server Error'}
            end

            # GET /users
            def index

              @db_users.get do |user|
                @information.push(id: user.document_id,
                                  user_information: user.data)
              end

              render json: {data: @information}
            end

            # GET /user/1
            def show
              user_idToken = params[:id]

              path_url = FIREBASE_GET_USER_INFO + FIREBASE_API_KEY
              uri_dest = URI.parse(path_url)
              http = Net::HTTP.new(uri_dest.host, uri_dest.port)
              http.use_ssl = true
              request = Net::HTTP::Post.new(uri_dest.request_uri)
              request.set_form_data("idToken": user_idToken)
              response = http.request(request)
              render json: response.body

              #info = {}
              #id = params[:id]
              #user = @db_users.doc(id).get.data
              #
              #unless id.nil? || user.nil?
              #  info['id'] = id
              #  user.each { |key, value|
              #    info[key] = value
              #  }
              #  render json: {data: info, status: "success", code: 200}
              #else
              #  @error_info[:status] = 404
              #  @error_info[:error] = 'Not Found'
              #  render json: @error_info
              #end
            end

            def hasDuplicate(fields)
              check_duplicate = @db_users.where("email", "=", "#{fields[:email]}")
              if check_duplicate.get() do |user|
                unless user.document_id.nil?
                  return 1
                end
              end
              end
              return 0
            end

            # POST /users
            def create
              path_url = FIREBASE_SING_UP_USER + FIREBASE_API_KEY
              uri_dest = URI.parse(path_url)
              http = Net::HTTP.new(uri_dest.host, uri_dest.port)
              http.use_ssl = true
              request = Net::HTTP::Post.new(uri_dest.request_uri)
              request.set_form_data({"email" => "testuser7@example.com", "password" => "666666", "returnSecureToken" => true})
              response = http.request(request)
              render json: response.body

              #end
              #
              #if isValid == 1
              #  @error_info[:status] = 400
              #  @error_info[:error] = 'Bad request'
              #  render json: @error_info, status: :bad_request
              #elsif hasDuplicate(fields) == 1
              #  @error_info[:status] = 409
              #  @error_info[:error] = 'Conflict'
              #  render json: @error_info, status: :conflict
              #else
              #  new_user = @db_users.add(fields)
              #  if new_user.document_id.nil?
              #    @error_info[:status] = 503
              #    @error_info[:error] = 'Service Unavailable'
              #    render json: @error_info, status: :service_unavailable
              #  end
              #
              #  render json: {status: "Created", code: 201}, status: :created
              #end
            end

            # PATCH/PUT /users/1
            def update
              render json: {status: "update ok", code: 204}
            end

            # DELETE /users/1
            def destroy
              id = params[:id]
              isExisted = @db_users.doc(id).get.data
              if isExisted.nil?
                @error_info[:status] = 204
                @error_info[:error] = 'No Content'
                render json: @error_info, status: :no_content
              else
                @db_users.doc(id).delete
                check_delete = @db_users.doc(id).get.data
                if check_delete.nil?
                  render json: {status: "Document deleted", code: 200}
                else
                  @error_info[:status] = 406
                  @error_info[:error] = 'Not Acceptable'
                  render json: @error_info, status: :not_acceptable
                end
              end
            end
          end
        end
      end
    end
  end
end