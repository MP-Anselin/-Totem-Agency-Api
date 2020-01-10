module Api
  module V1
    module FirebaseRequests
      # Class to manage the connection with Firebase
      class FireDatabaseStore < ApplicationController
        def initialize
          require 'google/cloud/firestore'
          # Explicitly use service account credentials by specifying the private key
          @firestore = Google::Cloud::Firestore.new project: FIREBASE_PROJECT_ID,
                                                    keyfile: FIREBASE_PATH_KEY

          @firebase = Firebase::Client.new(FIREBASE_URI, FIREBASE_PRIVATE_KEY)
        end
      end
    end
  end
end