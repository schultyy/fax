require './spec/spec_helper'
require './lib/couch_adapter'

describe 'CouchAdapter' do
  before :each do
    @host = 'http://localhost:5984'
    @db = 'foo'
    @couch = Fax::CouchAdapter.new(@host, @db)
    @couch.stub(:get).with(any_args) do |arg|
      arg
    end
  end
  it 'should have host set' do
    @couch.host.should eq(@host)
  end
  it 'should have database set' do
    @couch.database.should eq(@db)
  end
  context 'query view' do
    before do
      @design = 'customer'
      @view = 'all'
      @result = @couch.query_view(@design, @view)
    end
    it 'should check if design is nil' do
      expect { @couch.query_view(nil, @view) }.to raise_error
    end
    it 'should check if view is nil' do
      expect { @couch.query_view(@design, nil) }.to raise_error
    end
    it 'should include docs' do
      expected_query = "#{@host}/#{@db}/_design/#{@design}/_view/#{@view}?include_docs=true"
      @result.should eq(expected_query)
    end
  end
end
