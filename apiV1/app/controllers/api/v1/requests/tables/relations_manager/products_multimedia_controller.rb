module Api
  module V1
    module Requests
      module Tables
        module RelationsManager
          # class to manage products_multimedia tbale
          class ProductsMultimediaController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

              collection_init('products_multimedia')
            end

            # GET /products_multimedia/list of list the products_multimedia information
            def products_multimedia_list
              collection_list_documents
            end

            # POST /products_multimedia/list/id of list the products_multimedia information
            def products_multimedia_by_id
              multimedia_id = params[:multimedia_id]
              product_id = params[:product_id]
              list = []
              if var_empty(multimedia_id) && var_empty(product_id)
                rendering_answer("PRODUCTS_MULTIMEDIA multimedia_id  and product_id can't be empty", :bad_request)
              else
                query = if multimedia_id
                          @db_collection.where 'multimedia_id', '=', multimedia_id
                        elsif product_id
                          @db_collection.where 'product_id', '=', product_id
                        end

                query.get do |products_multimedia|
                  list.push(id: products_multimedia.document_id,
                            products_multimedia_information: products_multimedia.data)
                end
                rendering_answer nil, nil, list
              end
            end

            # POST /products_multimedia/information get one products_multimedia information
            def products_multimedia_information
              collection_get_document
            end

            def where_products_multimedia(multimedia_id, product_id)
              list = []
              sort_one = @db_collection.where 'multimedia_id', '=', multimedia_id
              query = sort_one.where 'product_id', '=', product_id

              query.get do |products_multimedia|
                list.push(id: products_multimedia.document_id,
                          products_multimedia_information: products_multimedia.data)
              end
              list
            end

            # POST /products_multimedia/new add new products_multimedia
            def new_products_multimedia
              multimedia_id = params[:multimedia_id]
              product_id = params[:product_id]

              if var_empty(multimedia_id) || var_empty(product_id)
                inf = var_empty(multimedia_id) ? 'multimedia_id' : 'product_id'
                rendering_answer('products_multimedia ' + inf + " can't be empty", :bad_request)
              elsif !where_products_multimedia(multimedia_id, product_id).empty?
                rendering_answer('products_multimedia already existed', :conflict)
              else
                fields = {multimedia_id: multimedia_id, product_id: product_id}
                new_document(fields)
              end
            end

            # POST /products_multimedia/update update user
            def update_products_multimedia
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # /products_multimedia/delete delete products_multimedia
            def delete_products_multimedia
              delete_document
            end
          end
        end
      end
    end
  end
end