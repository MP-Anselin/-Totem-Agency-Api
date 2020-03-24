module Api
  module V1
    module Requests
      module Tables
        module Beatcon
          module PathsManager
            # Class to manage the beacon path
            class BeaconPathsController < Api::V1::FirebaseRequests::FireDatabaseStore
              def initialize
                super

                $beatcon_paths = "beatcon_paths/"
                $path_coordinates = "/coordinates"
                collection_init('beatcon_paths')
              end

              # GET /beacon/paths/list of list the beacon paths coordinates information
              def beatcon_paths_list
                collection_list_documents
              end

              # POST /beacon/path get one product information
              def beacon_path_information
                coordinates_full_path = $beatcon_paths + params[:id].to_s + $path_coordinates
                collection = @firestore.col coordinates_full_path
                collection_list_documents collection
              end


              # POST /beacon/paths/new add new product
              def new_beacon_path
                doc_id = @firestore.col("beatcon_paths").add()
                full_path = $beatcon_paths + doc_id.document_id + $path_coordinates
                @firestore.col(full_path).add
                render json: {new_beacon_path_id: doc_id.document_id}
              end

              # /beacon/paths/delete delete product
              def delete_beacon_path
                delete_document
              end
            end
          end
        end
      end
    end
  end
end