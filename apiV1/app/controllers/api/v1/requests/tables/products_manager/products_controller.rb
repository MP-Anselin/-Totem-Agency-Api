module Api
  module V1
    module Requests
      module Tables
        module ProductsManager
          # Class to manage the products
          class ProductsController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

              @db_products = @firestore.col 'products'
              @information = []
              @error_info = {status: 500, error: 'Internal Server Error'}
            end

            # GET /products/list list the products information
            def product_list
              @db_products.get do |product|
                @information.push(id: product.document_id,
                                  product_information: product.data)
              end
              render json: {data: @information}
            end

            # POST /products/product get one product information
            def one_product
              db_product = @firestore.doc 'products/' + params[:id].to_s
              snapshot = db_product.get
              if snapshot.exists?
                render json: snapshot.data
              else
                @error_render[:error][:message] = 'Document does not exist'
                @error_render[:error][:errors][0][:message] = 'Document does not exist'
                @error_render[:error][:code] = 404
                render json: @error_render, status: :not_found
              end
            end

            def where_products(name, brand, url)
              list = []

              query = @db_products.where 'name', '=', name

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
              if (prod_name.nil? || prod_name == '') ||
                  (prod_brand.nil? || prod_brand == '') ||
                  (prod_url.nil? || prod_url == '')
                pro_inf = prod_name.nil? ? 'name' ? prod_brand.nil? : 'brand' : 'url'
                @error_render[:error][:message] = "Product " + pro_inf + " can't be empty"
                @error_render[:error][:errors][0][:message] = "Product " + pro_inf + " can't be empty"
                @error_render[:error][:code] = 400
                render json: @error_render, status: :bad_request
              elsif !where_products(prod_name, prod_brand, prod_url).empty?
                #@error_render.error_rend('Product already existed', 409)
                @error_render[:error][:message] = 'Product already existed'
                @error_render[:error][:errors][0][:message] = 'Product already existed'
                @error_render[:error][:code] = 409
                render json: @error_render, status: :conflict
              else
                @db_products.doc.set(name: prod_name, brand: prod_brand, url: prod_url)
              end
            end
          end
        end
      end
    end
  end
end
