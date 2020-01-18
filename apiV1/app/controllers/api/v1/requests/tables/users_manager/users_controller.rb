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

              collection_init('users')
            end

            # GET /users/list list of the users information
            def users_list
              collection_list_documents
            end

            # POST /users/user get one product information
            def user_information
              collection_get_document
            end

            def where_users(id)
              list = []
              query = @db_collection.where 'id', '=', id

              query.get do |product|
                list.push(id: product.document_id,
                          product_information: product.data)
              end
              list
            end

            # POST /users/user/new add new user
            def new_user
              user_id = params[:id]
              user_first_name = params[:firstName]
              user_last_name = params[:lastName]

              if (user_id.nil? || user_id == '') || (user_first_name.nil? || user_first_name == '') || (user_last_name.nil? || user_last_name == '')
                pro_inf = user_id.empty? ? 'id' : user_first_name.empty? ? 'first_name' : 'last_name'
                rendering_answer('User ' + pro_inf + " can't be empty", :bad_request)
              elsif !where_users(user_id).empty?
                rendering_answer('User already existed', :conflict)
              else
                new_document({first_name: user_first_name, last_name: user_last_name}, user_id)
              end
            end

            # POST /users/user/update update user
            def update_user
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # POST /users/user/delete delete user
            def delete_user
              delete_document
            end
          end
        end
      end
    end
  end
end