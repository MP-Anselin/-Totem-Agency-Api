module Api
  module V1
    module FirebaseRequests
      module FireTools
        # Class to manage the file on firebase
        class FirestorageManager < ApplicationController
          def initialize
            super
            require 'google/cloud/storage'

            # Explicitly use service account credentials by specifying the private key
            # file.
            @storage = Google::Cloud::Storage.new project: FIREBASE_PROJECT_ID,
                                                      keyfile: FIREBASE_PATH_KEY
          end

          def storage_variable
            @storage
          end


          #  List the bucket or the file in bucket
          def bucket_and_file_info(bucket_name)
            list = []
            element = if bucket_name.nil?
                        @storage.buckets
                      else
                        bucket = @storage.bucket bucket_name
                        bucket.files
                      end
            element.all do |info|
              list.push(name: info.name)
            end
            rendering_answer nil, nil, list
          end

          #  Download file
          def file_download
            bucket = params[:bucketName]
            file_path = params[:filePath]
            file_name = params[:fileName]
            file_destination = params[:fileDestination]
            file_new_name = params[:fileNewName]
            #bucket = @storage.bucket "totem-db-38dee.appspot.com"
            bucket = @storage.bucket bucket
            #file = bucket.file "IphoneXS.mp4"
            file = bucket.file file_path + '/' + file_name
            #file.download "app/controllers/api/v1/requests/tables/assets_manager/IphoneXS.mp4"
            file.download file_destination + '/' + file_new_name
            rendering_answer
          end

          # Create new bucket
          def new_bucket

            bucket = params[:bucketName]
            #@storage.create_bucket "test_create-attachments"
            @storage.create_bucket bucket
          end

          # Add new file in storage
          def new_file
            bucket = params[:bucketName]
            file_path = params[:filePath]
            file_name = params[:fileName]
            file_new_name = params[:fileNewName]
            file_destination = params[:fileDestination]
            #bucket = @storage.bucket "totem-db-38dee.appspot.com"
            bucket = @storage.bucket bucket
            #_file = "app/controllers/api/v1/requests/tables/assets_manager/Bob.jpg"
            path = file_path + '/' + file_name
            destination = file_destination + '/' + file_new_name
            bucket.create_file path, destination
            rendering_answer
          end

          # Delete file in storage
          def delete_file(bucket, folder_path, file_name)
            #bucket = @storage.bucket bucket
            #file_path = folder_path == '' ? file_name : folder_path + '/' + file_name
            #file = bucket.file file_path
            #file.delete
            render json: {data: "tot"}

              #rendering_answer
          end
        end
      end
    end
  end
end
