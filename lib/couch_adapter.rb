require 'json'

class CouchAdapter
  def initialize(host, database)
    @host = host
    @database = database
  end
  def query_view(design, view_name)
    request("GET", "_design/#{design}/_view/#{view_name}")
  end
  private
  def request(method, actual_request)
    JSON.parse(`curl -X#{method} #{@host}/#{@database}/#{actual_request}`)
  end
end
