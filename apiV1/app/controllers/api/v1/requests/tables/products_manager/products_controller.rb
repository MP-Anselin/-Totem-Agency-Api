module Api
  module V1
    module Requests
      module Tables
        module ProductsManager
          # Class to manage the products
          class ProductsController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

              collection_init('products')
            end

            # GET /products/list of list the products information
            def products_list
              collection_list_documents
            end

            # POST /products/product get one product information
            def product_information
              collection_get_document
            end

            def where_products(name, brand, url)
              list = []
              sort_name = @db_collection.where 'name', '=', name
              sort_name_brand = sort_name.where 'brand', '=', brand
              query = sort_name_brand.where 'url', '=', url

              query.get do |product|
                list.push(id: product.document_id,
                          product_information: product.data)
              end
              list
            end

            # POST /products/product/new add new product
            def new_product
              prod_name = params[:name]
              prod_brand = params[:brand]
              prod_url = params[:url]

              if (prod_name.nil? || prod_name == '') || (prod_brand.nil? || prod_brand == '') || (prod_url.nil? || prod_url == '')
                pro_inf = prod_name.empty? ? 'name' : prod_brand.empty? ? 'brand' : 'url'
                rendering_answer('Product ' + pro_inf + " can't be empty", :bad_request)
              elsif !where_products(prod_name, prod_brand, prod_url).empty?
                rendering_answer('Product already existed', :conflict)
              else
                new_document({name: prod_name, brand: prod_brand, url: prod_url})
              end
            end

            # POST /products/product/update update user
            def update_product
              id = params[:id]
              if id.nil? || id == ''
                rendering_answer('User ' + 'id' + " can't be empty", :bad_request)
              else
                update_document
              end
            end

            # /products/product/delete delete product
            def delete_product
              delete_document
            end
          end
        end
      end
    end
  end
end
