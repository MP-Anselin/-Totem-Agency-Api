module Api
  module V1
    module Requests
      module HttpRequests
        # Class to manage http request
        class HttpRequestsManager
          # function to exec curl request to firebase
          def curl_exe(path, params)
            uri_dest = URI.parse(path)
            http = Net::HTTP.new(uri_dest.host, uri_dest.port)
            http.use_ssl = true
            request = Net::HTTP::Post.new(uri_dest.request_uri)
            request.set_form_data(params)
            http.request(request)
          end
        end
      end
    end
  end
end