module Api
  module V1
    module Requests
      module Tables
        module MultimediaManager
          # Class to manage the assets
          class AssetsController < Api::V1::FirebaseRequests::FireDatabaseStore
            def initialize
              super

                #@multimedia = Api::V1::Requests::Tables::MultimediaManager::MultimediaController.new
            end

            # GET/ /assets/bucket/list of list the assets information
            def buckets_list
              list = []
              element = @firestorage.storage_variable.buckets
              element.all do |info|
                list.push(name: info.name)
              end
              rendering_answer nil, nil, list
            end

            # POST /assets/bucket/multimedia/list of list the assets information
            def assets_list
              bucket_name = params[:bucketName]
              if var_empty(bucket_name)
                rendering_answer("Bucket name  can't be empty", :bad_request)
              else
                list = []
                bucket = @firestorage.storage_variable.bucket bucket_name
                bucket.files.all do |info|
                  file_storage_id = info.id.split('/').last.split('/')[0]
                  list.push(name: info.name, size: info.size, id_path: info.id, id: file_storage_id,
                            bucket: info.bucket, content_type: info.content_type)
                end
                rendering_answer nil, nil, list
              end
            end

            # POST /assets/bucket/multimedia/download get one asset information
            def asset_download
              bucket = params[:bucketName]
              folder_path = params[:folderPath]
              file_name = params[:fileName]
              folder_destination = params[:folderDestination]
              file_new_name = params[:fileNewName]
              if var_empty(bucket) || var_empty(folder_path) || var_empty(file_name) || var_empty(folder_destination)
                inf = var_empty(bucket) ? 'bucket' : var_empty(folder_path) ? 'folder path' : var_empty(file_name) ? 'file name' : 'folder_destination'
                rendering_answer('Asset ' + inf + " can't be empty", :bad_request)
              else
                #bucket = @firestorage.storage_variable.bucket "totem-db-38dee.appspot.com"
                bucket = @firestorage.storage_variable.bucket bucket
                #file = bucket.file "IphoneXS.mp4"
                begin
                  file = folder_path == '' ? bucket.file(file_name) : bucket.file(folder_path + '/' + file_name)
                  #file.download "app/controllers/api/v1/requests/tables/multimedia_manager/IphoneXS.mp4"
                  file.download folder_destination + '/' + file_new_name
                rescue StandardError
                  rendering_answer('BAD REQUEST', :bad_request)
                else
                  rendering_answer
                end
              end
            end

            # POST /assets/bucket/multimedia/new add new asset
            def new_asset
              bucket = params[:bucketName]
              folder_path = params[:folderPath]
              file_name = params[:fileName]
              file_new_name = params[:fileNewName]
              folder_destination = params[:folderDestination]
              if var_empty(bucket) || var_empty(folder_path) || var_empty(file_name) || var_empty(folder_destination)
                inf = var_empty(bucket) ? 'bucket' : var_empty(folder_path) ? 'folder path' : var_empty(file_name) ? 'file name' : 'folder_destination'
                rendering_answer('Asset ' + inf + " can't be empty", :bad_request)
              else
                #bucket = @firestorage.storage_variable.bucket "totem-db-38dee.appspot.com"
                bucket = @firestorage.storage_variable.bucket bucket
                #_file = "app/controllers/api/v1/requests/tables/multimedia_manager/Bob.jpg"
                file_path = folder_path == '' ? file_name : folder_path + '/' + file_name
                destination = folder_destination + '/' + (file_new_name == '' ? file_name : file_new_name)
                begin
                  file = bucket.create_file file_path, destination
                rescue StandardError
                  rendering_answer('BAD REQUEST', :bad_request)
                else
                  {'path_name': file.name, size: file.size, path_id: file.id, bucket: file.bucket, content_type: file.content_type}
                end
              end
            end

            # POST /assets/bucket/multimedia/delete delete asset
            def delete_asset
              bucket = params[:bucketName]
              folder_path = params[:folderPath]
              file_name = params[:fileName]

              if var_empty(bucket) || !folder_path || var_empty(file_name)
                inf = !bucket ? 'bucket' : !folder_path ? 'folder path' : 'file name'
                rendering_answer('Asset ' + inf + " can't be empty", :bad_request)
              else
                bucket = @firestorage.storage_variable.bucket bucket
                file_path = folder_path == '' ? file_name : folder_path + '/' + file_name
                begin
                  file = bucket.file file_path
                  file.delete
                rescue StandardError
                  rendering_answer('BAD REQUEST', :bad_request)
                else
                  rendering_answer
                end
              end
            end
          end
        end
      end
    end
  end
end
