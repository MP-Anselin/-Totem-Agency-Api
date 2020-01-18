module Api
  module V1
    module Requests
      module Tables
        module RelationsManager
          # Class to manage user_manager table
          class UsersMultimediaController < ApplicationController
            def initialize
              super

              collection_init('users_multimedia')
            end

            # GET /multimedia/users/list of list the users_multimedia information
            def users_multimedia_list
              collection_list_documents
            end

            # POST /multimedia/user get one multimediaType information
            def users_multimedia_information
              collection_get_document
            end

            def where_multimedia(name, storage_id, type)
              list = []
              sort_one = @db_collection.where 'name', '=', name
              sort_two = sort_one.where 'storage_id', '=', storage_id
              query = sort_two.where 'type', '=', type

              query.get do |multimedia|
                list.push(id: multimedia.document_id,
                          multimedia_information: multimedia.data)
              end
              list
            end

            # POST /assets/multimedia/new add new asset
            def new_multimedia
            end

            # POST /multimedia/users/update update user
            def update_multimedia
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # /multimedia/users/delete delete users_multimedia
            def delete_multimedia
              delete_document
            end
          end
        end
      end
    end
  end
end
