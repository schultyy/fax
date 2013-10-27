require 'rspec'
require 'rack/test'
require 'json'
require_relative '../lib/fax.rb'
ENV['RACK_ENV'] = 'test'
require 'factory_girl'
Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def json_response
  JSON.parse(last_response.body)
end
