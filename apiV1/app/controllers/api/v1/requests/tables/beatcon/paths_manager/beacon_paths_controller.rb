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

                collection_init('beatcon_paths')
              end

              # GET /beacon/paths/list of list the beacon paths coordinates information
              def beatcon_paths_list
                collection_list_documents
              end

              # POST /beacon/path get one product information
              def beacon_path_information
                collection_get_document
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

              # POST /beacon/paths/new add new product
              def new_beacon_path
                prod_y_axe = params[:y_axe]
                prod_x_axe = params[:x_axe]
                prod_z_axe = params[:z_axe]

                if (prod_z_axe.nil? || prod_z_axe == '') || (prod_x_axe.nil? || prod_x_axe == '') || (prod_y_axe.nil? || prod_y_axe == '')
                  pro_inf = prod_y_axe.empty? ? 'y_axe' : prod_x_axe.empty? ? 'x_axe' : 'z_axe'
                  rendering_answer('The ' + pro_inf + " can't be empty", :bad_request)
                elsif !where_beacon_paths(prod_y_axe, prod_x_axe, prod_z_axe).empty?
                  rendering_answer('Product already existed', :conflict)
                else
                  new_document({y_axe: prod_y_axe, x_axe: prod_x_axe, z_axe: prod_z_axe})
                end
              end

              # POST /beacon/paths/update update user
              def update_beacon_path
                id = params[:id]
                if id.nil? || id == ''
                  rendering_answer('Beacon path ' + 'id' + " can't be empty", :bad_request)
                else
                  update_document
                end
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