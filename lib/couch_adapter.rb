require 'json'
require 'curb'
require 'addressable/uri'

module Fax
  class CouchAdapter
    attr_accessor :host, :database
    def initialize(host, database)
      @host = host
      @database = database
    end
    def query_view_with_params(design, view_name, params)
      raise Error('design must be set') unless design
      raise Error('view_name must be set') unless view_name
      raise Error('params must be set') unless params

      base_url = create_view_url(design, view_name)
      return get(base_url) if params.empty?

      url_with_params = base_url + '?' + params.map do |k,v| 
        if v.class == String
          "#{k}=\"#{v}\"" 
        else
          "#{k}=#{v}"
        end
      end.join('&')
      get(url_with_params)
    end
    def query_view(design, view_name)
      raise Error('design must be set') unless design 
      raise Error('view_name must be set') unless view_name
      query = create_view_url(design, view_name)
      get(include_docs(query))
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
    def include_docs(query)
      query + '&include_docs=true' if query.include? '?'
      query + '?include_docs=true'
    end
    def post(actual_request, params)
      result = Curl.post(actual_request, params) do |curl|
        curl.headers['Content-Type'] = 'application/json'
      end
      result.body_str
    end
    def get(actual_request)
      parsed_uri = Addressable::URI.parse(actual_request).to_s
      result_set = Curl.get(parsed_uri)
      JSON.parse(result_set.body_str)
    end
  end
end
