module Api
  module V1
    module Requests
      module Tables
        module MultimediaManager
          # Class to manage "multimedia type" table
          class MultimediaTypesController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

              collection_init('multimedia_types')
            end

            # GET /multimediaTypes/list of list the multimediaTypes information
            def multimedia_types_list
              collection_list_documents
            end

            # POST /multimedia/multimediaType get one multimediaType information
            def multimedia_types_information
              collection_get_document
            end

            def where_multimedia_types(name, brand, url)
              list = []
              sort_name = @db_collection.where 'name', '=', name
              sort_name_brand = sort_name.where 'brand', '=', brand
              query = sort_name_brand.where 'url', '=', url

              query.get do |multimedia_type|
                list.push(id: multimedia_type.document_id,
                          multimedia_type_information: multimediaType.data)
              end
              list
            end

            def new_multimedia_types
              prod_name = params[:name]
              prod_brand = params[:brand]
              prod_url = params[:url]

              if (prod_name.nil? || prod_name == '') || (prod_brand.nil? || prod_brand == '') || (prod_url.nil? || prod_url == '')
                pro_inf = prod_name.empty? ? 'name' : prod_brand.empty? ? 'brand' : 'url'
                rendering_answer('multimediaType ' + pro_inf + " can't be empty", :bad_request)
              elsif !where_multimedia_types(prod_name, prod_brand, prod_url).empty?
                rendering_answer('multimediaType already existed', :conflict)
              else
                new_document({name: prod_name, brand: prod_brand, url: prod_url})
              end
            end

            # POST /multimediaTypes/multimediaType/update update user
            def update_multimedia_types
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # /multimediaTypes/multimediaType/delete delete multimediaType
            def delete_multimedia_types
              delete_document
            end
          end
        end
      end
    end
  end
end
