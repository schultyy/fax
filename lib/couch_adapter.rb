require 'json'
module Fax
  class CouchAdapter
    def initialize(host, database)
      @host = host
      @database = database
    end
    def query_view(design, view_name, include_docs)
      query = "_design/#{design}/_view/#{view_name}"
      query << "?include_docs=true" if include_docs
      request("GET", query)
    end
    private
    def request(method, actual_request)
      JSON.parse(`curl -X#{method} #{@host}/#{@database}/#{actual_request}`)
    end
  end
end
