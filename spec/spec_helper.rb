require 'rspec'
require 'rack/test'
require_relative '../lib/fax.rb'
ENV['RACK_ENV'] = 'test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
