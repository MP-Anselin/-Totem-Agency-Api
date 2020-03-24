module Api
  module V1
    module FirebaseRequests
      # Class to manage the connection with Firebase
      class FireDatabaseStore < ApplicationController

        def initialize
          super

          # Explicitly use service account credentials by specifying the private key
          @firestore = Api::V1::FirebaseRequests::FireTools::FirestoreManager.new.firestore_variable
          @firebase = Api::V1::FirebaseRequests::FireTools::FirebaseManager.new.firebase_variable
          @firestorage = Api::V1::FirebaseRequests::FireTools::FirestorageManager.new


          @collection = nil
          @collection_name = nil
        end

        def collection_init(collection_path)
          @collection_name = collection_path
          @db_collection = @firestore.col @collection_name
        end

        def collection_list_documents(collection = nil)
          the_collection = collection ? collection : @db_collection
          list = []
          the_collection.get do |doc|
            list.push(id: doc.document_id, document_information: doc.data)
          end
          rendering_answer nil, nil, list
        end

        def collection_get_document(collection = nil)
          the_collection = collection ? collection : @db_collection
          path = the_collection + '/' + params[:id].to_s
          db_document = @firestore.doc path
          snapshot = db_document.get
          if snapshot.exists?
            rendering_answer(nil, nil, snapshot.data)
          else
            rendering_answer('Document does not exist', :not_found)
          end
        end

        def new_document(fields, id = nil, rend_info = false)
          id.nil? ? @db_collection.doc.set(fields) : @db_collection.doc(id).set(fields)
          if rend_info
            rendering_answer(nil, nil, fields)
          else
            rendering_answer
          end
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

        def update_document
          id = params[:id]
          if id_document(id)
            rendering_answer('Document does not exist', :not_found)
          else
            data = params.permit(params.keys).to_h || {}
            data.delete(:path_id)
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