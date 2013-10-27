require 'json'
require 'curb'

module Fax
  class CouchAdapter
    def initialize(host, database)
      @host = host
      @database = database
    end
    def query_view_with_param(design, view_name, params_hash = {})
      base_url = create_view_url(design, view_name)
      get(base_url, params_hash.to_json)
    end
    def query_view(design, view_name)
      query = create_view_url(design, view_name)
      get(query, {:include_docs => true}) 
    end
    def save_mail(doc)
      post(host_with_db, doc.to_json)
    end
    private
    def host_with_db
      "#{@host}/#{@database}"
    end
    def create_view_url(design, view_name)
      "#{@host}/#{@database}/_design/#{design}/_view/#{view_name}"
    end
    def post(actual_request, params)
      result = Curl.post(actual_request, params) do |curl|
        curl.headers['Content-Type'] = 'application/json'
      end
      result.body_str
    end
    def get(actual_request, params)
      result_set = Curl.get(actual_request, params)
      JSON.parse(result_set.body_str)
    end
  end
end
