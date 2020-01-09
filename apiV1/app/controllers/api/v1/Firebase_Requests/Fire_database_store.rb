module Api
  module V1
    module FirebaseRequests
      # Class to manage the connection with Firebase
      class FireDatabaseStore < ApplicationController
        FIREBASE_URI = 'https://totem2-f3e2e.firebaseio.com/'.freeze
        FIREBASE_PATH_KEY = 'app/controllers/api/v1/resources/totem2-f3e2e-firebase-adminsdk-lfqcp-3e7ed4ba43.json'.freeze
        FIREBASE_PROJECT_ID = 'totem2-f3e2e'.freeze
        FIREBASE_PRIVATE_KEY = File.open(FIREBASE_PATH_KEY).read.freeze
        FIREBASE_API_KEY = 'AIzaSyAriR9Ydg4l0frGiJ2-0SpbE82xxRWVtEM'.freeze

        FIREBASE_SING_UP_USER = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key='.freeze

        def initialize
          require 'google/cloud/firestore'

          # Explicitly use service account credentials by specifying the private key
          # file.
          @firestore = Google::Cloud::Firestore.new project: FIREBASE_PROJECT_ID,
                                                    keyfile: FIREBASE_PATH_KEY

          @firebase = Firebase::Client.new(FIREBASE_URI, FIREBASE_PRIVATE_KEY)
        end
      end
    end
  end
end