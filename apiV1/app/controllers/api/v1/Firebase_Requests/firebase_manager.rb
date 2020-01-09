class Api::V1::FirebaseRequests::FirebaseManager < ApplicationController
  @@BASE_URI = 'https://totem2-f3e2e.firebaseio.com/'
  @@PRIVATE_KEY_JSON_STRING = File.open('app/controllers/api/v1/resources/totem2-f3e2e-firebase-adminsdk-lfqcp-3e7ed4ba43.json').read

  def initialize
    @firebase = Firebase::Client.new(@@BASE_URI, @@PRIVATE_KEY_JSON_STRING)
  end

  def get(path)
    @firebase.get(path)
      #t = @firebase.auth
  end

  def set(path, data)
    @firebase.collection('password').get()
      #@firebase.set(path, data)
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