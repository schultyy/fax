require './spec/spec_helper'
require './lib/faxgeraet'

describe 'The fax app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    @fax = double("Fax::Faxgeraet")
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('"hello"')
  end
  context 'GET /folders' do
    before do
      Fax::Faxgeraet.stub(:new).with(any_args).and_return(@fax)
      @fax.stub(:fetch_folders).with(any_args).and_return([])
      get '/folders'
    end
    it 'responds with 200' do
      last_response.status.should eq(200)
      #expect(last_response).to be_ok
    end
  end
end
