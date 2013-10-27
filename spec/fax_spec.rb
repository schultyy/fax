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
      folder = FactoryGirl.build :folder
      allow(@fax).to receive(:fetch_folders).and_return([folder])
      get '/folders'
    end
    it 'responds with 200' do
      last_response.status.should eq(200)
    end
    it 'is an array' do
      json_response.class.should eq(Array)
    end
    context 'A single folder' do
      subject{ json_response.first }

      it 'has id attribute' do
        subject.has_key?(:_id)
      end
      it 'has name attribute' do
        subject.has_key?(:name)
      end
    end
  end
end
