module Api
  module V1
    module Requests
      module Tables
        module RelationsManager
          # Class to manage users_multimedia table
          class UsersMultimediaController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

              collection_init('users_multimedia')
            end

            # GET /users_multimedia/list of list the users_multimedia information
            def users_multimedia_list
              collection_list_documents
            end

            # POST /users_multimedia/list/id of list the users_multimedia information
            def users_multimedia_by_id
              multimedia_id = params[:multimedia_id]
              user_id = params[:user_id]
              list = []
              if var_empty(multimedia_id) && var_empty(user_id)
                rendering_answer("USERS_MULTIMEDIA multimedia_id  and user_id can't be empty", :bad_request)
              else
                query = if multimedia_id
                          @db_collection.where 'multimedia_id', '=', multimedia_id
                        elsif user_id
                          @db_collection.where 'user_id', '=', user_id
                        end

                query.get do |users_multimedia|
                  list.push(id: users_multimedia.document_id,
                            users_multimedia_information: users_multimedia.data)
                end
                rendering_answer nil, nil, list
              end
            end

            # POST /users_multimedia/information get one users_multimedia information
            def users_multimedia_information
              collection_get_document
            end

            def where_users_multimedia(multimedia_id, user_id)
              list = []
              sort_one = @db_collection.where 'multimedia_id', '=', multimedia_id
              query = sort_one.where 'user_id', '=', user_id

              query.get do |users_multimedia|
                list.push(id: users_multimedia.document_id,
                          users_multimedia_information: users_multimedia.data)
              end
              list
            end

            # POST /users_multimedia/new add new users_multimedia
            def new_users_multimedia
              multimedia_id = params[:multimedia_id]
              user_id = params[:user_id]

              if var_empty(multimedia_id) || var_empty(user_id)
                inf = var_empty(multimedia_id) ? 'multimedia_id' : 'user_id'
                rendering_answer('USERS_MULTIMEDIA ' + inf + " can't be empty", :bad_request)
              elsif !where_users_multimedia(multimedia_id, user_id).empty?
                rendering_answer('users_multimedia already existed', :conflict)
              else
                fields = {multimedia_id: multimedia_id, user_id: user_id}
                new_document(fields)
              end
            end

            # POST /users_multimedia/update update user
            def update_users_multimedia
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # /users_multimedia/delete delete users_multimedia
            def delete_users_multimedia
              delete_document
            end
          end
        end
      end
    end
  end
end
