module Api
  module V1
    module FirebaseRequests
      module FireTools
        # Class to manage database on firestore (firebase website)
        class FirestoreManager < ApplicationController
          def initialize
            require 'google/cloud/firestore'

            # Explicitly use service account credentials by specifying the private key
            # file.
            @firestore = Google::Cloud::Firestore.new project: FIREBASE_PROJECT_ID,
                                                      keyfile: FIREBASE_PATH_KEY
          end

          def firestore_variable
            @firestore
          end
        end
      end
    end
  end
end
