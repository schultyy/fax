require 'rspec'
require 'rack/test'
require_relative '../lib/fax.rb'
ENV['RACK_ENV'] = 'test'
require 'factory_girl'
Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
