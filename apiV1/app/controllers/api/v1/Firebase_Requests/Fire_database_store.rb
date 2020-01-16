module Api
  module V1
    module FirebaseRequests
      # Class to manage the connection with Firebase
      class FireDatabaseStore < ApplicationController

        def initialize
          super
          require 'google/cloud/firestore'
          # Explicitly use service account credentials by specifying the private key
          @firestore = Google::Cloud::Firestore.new project: FIREBASE_PROJECT_ID,
                                                    keyfile: FIREBASE_PATH_KEY
          @firebase = Firebase::Client.new(FIREBASE_URI, FIREBASE_PRIVATE_KEY)

          @collection = nil
          @collection_name = nil
        end

        def collection_init(collection_path)
          @collection_name = collection_path
          @db_collection = @firestore.col @collection_name
        end

        def collection_list_documents
          list = []
          @db_collection.get do |doc|
            list.push(id: doc.document_id, document_information: doc.data)
          end
          rendering_answer nil, nil, list
        end

        def collection_get_document
          path = @collection_name + '/' + params[:id].to_s
          db_document = @firestore.doc path
          snapshot = db_document.get
          if snapshot.exists?
            rendering_answer(nil, nil, snapshot.data)
          else
            rendering_answer('Document does not exist', :not_found)
          end
        end

        def new_document(fields, id = nil)
          id.nil? ? @db_collection.doc.set(fields) : @db_collection.doc(id).set(fields)
          rendering_answer
        end

        def id_document(id)
          path = @collection_name + '/' + id
          db_document = @firestore.doc path
          snapshot = db_document.get
          if snapshot.exists?
            false
          else
            true
          end
        end

        # POST /products/product/update update product
        def update_document
          if id_document(params[:id])
            rendering_answer('Document does not exist', :not_found)
          else
            data = params.permit(params.keys).to_h || {}
            data.delete(:user)
            data.delete(:controller)
            data.delete(:action)
            data.delete(:id)
            @db_collection.doc(id).set(data, merge: true)
            rendering_answer
          end
        end

        def delete_document
          db_product = @firestore.doc @collection_name + '/' + params[:id].to_s
          db_product.delete
          rendering_answer
        end
      end
    end
  end
end