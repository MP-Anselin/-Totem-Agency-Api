module Api
  module V1
    module FirebaseRequests
      module FireTools
        # Class to manage the firebase real time
        class FirebaseManager < ApplicationController

          def initialize
            require 'google/cloud/firestore'
            @firebase = Firebase::Client.new(FIREBASE_URI, FIREBASE_PRIVATE_KEY)

          end

          def firebase_variable
            @firebase
          end

          def get(path)
            @firebase.get(path)
          end

          def set(path, data)
            @firebase.collection().get()
          end

          def delete(path)
            @firebase.delete(path)
          end

          def push(path, data)
            @firebase.push(path, data)
          end

          def update(path, data)
            @firebase.update(path, data)
          end
        end
      end
    end
  end
end