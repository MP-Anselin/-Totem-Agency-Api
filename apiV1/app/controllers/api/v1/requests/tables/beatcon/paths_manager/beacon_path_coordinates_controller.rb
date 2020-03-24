module Api
  module V1
    module Requests
      module Tables
        module Beatcon
          module PathsManager
            # Class to manage the beacon path coordinates
            class BeaconPathCoordinatesController < Api::V1::FirebaseRequests::FireDatabaseStore
              def initialize
                super

                $beatcon_paths = "beatcon_paths/"
                $path_coordinates = "/coordinates"
              end

              def init_route
                path_id = params[:path_id]
                return_res = true
                if path_id.nil? || path_id == ''
                  rendering_answer("Path id of coordinates can't be empty", :bad_request)
                  return_res = false
                else
                  full_path = $beatcon_paths + path_id + $path_coordinates
                  collection_init(full_path)
                  return_res
                end
                return_res
              end

              # POST /beacon/path/coordinates/list of list the beacon paths coordinates information
              def beatcon_path_coordinates_list
                if (init_route)
                  collection_list_documents
                end
              end

              # POST /beacon/path/coordinates get one product information
              def beacon_path_coordinates_information
                if (init_route)
                  collection_get_document
                end
              end


              def where_beacon_paths(prod_y_axe, prod_x_axe, prod_z_axe)
                list = []
                sort_name = @db_collection.where 'y_axe', '=', prod_y_axe
                sort_name_brand = sort_name.where 'x_axe', '=', prod_x_axe
                query = sort_name_brand.where 'z_axe', '=', prod_z_axe

                query.get do |product|
                  list.push(id: product.document_id,
                            product_information: product.data)
                end
                list
              end

              # POST /beacon/path/coordinates/new add new product
              def new_beacon_path_coordinates
                if (init_route)
                  prod_y_axe = params[:y_axe]
                  prod_x_axe = params[:x_axe]
                  prod_z_axe = params[:z_axe]

                  if (prod_z_axe.nil? || prod_z_axe == '') || (prod_x_axe.nil? || prod_x_axe == '') || (prod_y_axe.nil? || prod_y_axe == '')
                    pro_inf = prod_y_axe.empty? ? 'y_axe' : prod_x_axe.empty? ? 'x_axe' : 'z_axe'
                    rendering_answer('The ' + pro_inf + " can't be empty", :bad_request)
                  else
                    new_document({y_axe: prod_y_axe, x_axe: prod_x_axe, z_axe: prod_z_axe})
                  end
                end
              end

              # POST /beacon/paths/coordinates/update update user
              def update_beacon_path_coordinates
                if (init_route)
                  id = params[:id]
                  if id.nil? || id == ''
                    rendering_answer("Beacon path coordinates id can't be empty", :bad_request)
                  else
                    update_document
                  end
                end
              end

              # /beacon/path/coordinates delete product
              def delete_beacon_path_coordinates
                if (init_route)
                  delete_document
                end
              end
            end
          end
        end
      end
    end
  end
end
