require './spec/spec_helper'
require './lib/couch_adapter'

describe 'CouchAdapter' do
  before :each do
    @host = 'http://localhost:5984'
    @db = 'foo'
    @design = 'customer'
    @view = 'all'
    @base_query = "#{@host}/#{@db}/_design/#{@design}/_view/#{@view}"
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
      @result = @couch.query_view(@design, @view)
    end
    it 'should check if design is nil' do
      expect { @couch.query_view(nil, @view) }.to raise_error
    end
    it 'should check if view is nil' do
      expect { @couch.query_view(@design, nil) }.to raise_error
    end
    it 'should include docs' do
      expected_query = @base_query + '?include_docs=true'
      @result.should eq(expected_query)
    end
  end
  context 'query view with parameters' do
    it 'should check if design is nil' do
      expect { @couch.query_view_with_params(nil, @view, {}) }.to raise_error
    end
    it 'should check if view is nil' do
      expect { @couch.query_view_with_params(@design, nil, {}) }.to raise_error
    end
    it 'should check if params is nil' do
      expect { @couch.query_view_with_params(@design, @view, nil) }.to raise_error
    end
    context 'empty params hash' do
      before do
        @result = @couch.query_view_with_params(@design, @view, {})
      end
      it 'should return base url' do
        @result.should eq(@base_query)
      end
    end
    context 'with params' do
      it 'should include docs' do
        params = {'include_docs' => true}
        result = @couch.query_view_with_params(@design, @view, params)
        expected = @base_query + '?include_docs=true'
        result.should eq(expected)
      end
      it 'should include key' do
        params = { 'key' => 'abc' }
        result = @couch.query_view_with_params(@design, @view, params)
        expected = @base_query + '?key="abc"'
        result.should eq(expected)
      end
    end
  end
end
