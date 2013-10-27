require './spec/spec_helper'
require './lib/faxgeraet'

describe 'The fax app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    @fax = double("Fax::Faxgeraet")
    Fax::Faxgeraet.stub(:new).with(any_args).and_return(@fax)
  end
  context 'GET /folders' do
    before do
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
  context 'GET /Inbox' do
    before do
      mail = FactoryGirl.build :mail
      allow(@fax).to receive(:show_folder_content).and_return([mail])
      get '/Inbox'
    end
    it 'responds with 200' do
      last_response.status.should eq(200)
    end
    it 'is an array' do
      json_response.class.should eq(Array)
    end
    context 'A single folder' do
      subject { json_response.first } 

      it 'has id attribute' do
        subject.has_key?(:_id)
      end
      it 'has from attribute' do
        subject.has_key?(:from)
      end
      it 'has to attribute' do
        subject.has_key?(:to)
      end
      it 'has subject attribute' do
        subject.has_key?(:subject)
      end
      it 'has body attribute' do
        subject.has_key?(:body)
      end
      it 'has folder_id attribute' do
        subject.has_key?(:folder_id)
      end
      it 'has message_id attribute' do
        subject.has_key?(:message_id)
      end
    end
  end
end
