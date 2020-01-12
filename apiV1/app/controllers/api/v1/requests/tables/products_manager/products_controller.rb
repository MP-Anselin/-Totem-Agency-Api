module Api
  module V1
    module Requests
      module Tables
        module ProductsManager
          class ProductsController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

              @db_products = @firestore.col 'products'
              @information = []
              @error_info = {status: 500, error: 'Internal Server Error'}
            end

            # GET /products/list
            def product_list
              #@db_products.get do |products|
              # @information.push(id: products.document_id,
              #                   products_information: products.data)
              #end
              #test = @db_products.get

              @db_products.doc('3').set(brand: 'test', name: 'test', url: '')

               #render json: {data: @information}, status: :ok
               #render json: {data: test}, status: :ok
            end
          end
        end
      end
    end
  end
end
