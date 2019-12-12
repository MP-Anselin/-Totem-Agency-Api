class FirebaseManager
  def firebase_verification(token)
    url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=#{ENV['AIzaSyAriR9Ydg4l0frGiJ2-0SpbE82xxRWVtEM
']}"
    firebase_verification_call = HTTParty.post(url, headers: { 'Content-Type' => 'application/json' }, body: { 'idToken' => token }.to_json )
    if firebase_verification_call.response.code == "200"
      firebase_infos = firebase_verification_call.parsed_response
    else
      raise CustomError
    end
  end
end