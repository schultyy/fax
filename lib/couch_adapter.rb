require 'json'
module Fax
  class CouchAdapter
    def initialize(host, database)
      @host = host
      @database = database
    end
    def query_view_with_param(design, view_name, param, include_docs)
      base_url = create_view_url(design, view_name, include_docs) << '&' << param
      puts base_url
      request('GET', base_url)
    end
    def query_view(design, view_name, include_docs)
      query = create_view_url(design, view_name, include_docs)
      request('GET', query)
    end
    private
    def create_view_url(design, view_name, include_docs)
      base_url = "_design/#{design}/_view/#{view_name}"
      base_url << '?include_docs=true' if include_docs
      base_url
    end
    def request(method, actual_request)
      JSON.parse(`curl -X#{method} #{@host}/#{@database}/#{actual_request}`)
    end
  end
end
