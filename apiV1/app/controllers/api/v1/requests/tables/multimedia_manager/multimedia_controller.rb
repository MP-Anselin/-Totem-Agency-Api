module Api
  module V1
    module Requests
      module Tables
        module MultimediaManager
          # Class to manage multimedia table
          class MultimediaController < Api::V1::Requests::Tables::MultimediaManager::AssetsController
            def initialize
              super

              collection_init('multimedia')
            end

            # GET /multimedia/file/list of list the multimediaTypes information
            def multimedia_list
              collection_list_documents
            end

            # POST /multimedia/file get one multimediaType information
            def multimedia_information
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
              list = new_asset
              if list.nil?
                file_name = list[:path_name].split('/').last.split('/')[0]
                file_storage_id = list[:path_id].split('/').last.split('/')[0]
                storage_path = list[:path_name].split(file_name)[0]
                if !where_multimedia(file_name, file_storage_id, list[:content_type]).empty?
                  rendering_answer('multimedia already existed', :conflict)
                else
                  new_document({name: file_name, storage_id: file_storage_id,
                                type: list[:content_type], storage_path: storage_path}, file_storage_id)
                end
              end
            end

            # POST /multimedia/file/update update user
            def update_multimedia
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # /multimedia/file/delete delete multimediaType
            def delete_multimedia
              delete_document
            end
          end
        end
      end
    end
  end
end
