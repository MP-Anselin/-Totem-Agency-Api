class Api::V1::FirebaseRequests::FirestoreManager < ApplicationController
  def initialize
    require 'google/cloud/firestore'
    project_id = 'totem2-f3e2e'
    key_file = 'app/controllers/api/v1/resources/totem2-f3e2e-firebase-adminsdk-lfqcp-3e7ed4ba43.json'

    # Explicitly use service account credentials by specifying the private key
    # file.
    @firestore = Google::Cloud::Firestore.new project: project_id, keyfile: key_file
  end

  def test
    users_rf = @firestore.col "users"

    #users_rf.get.each {|user| puts user.document_id, data: user.data}
    users_rf.doc("Emn0pMweoCXIfbkkKNTA").get
  end
end