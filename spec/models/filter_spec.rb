require 'spec_helper'
require 'fixtures/filter_helper'

describe Filter do
  GET_CASE_URL = "https://joseph.desk.com/api/v2/filters"
  
  before do
    stub_request(:get, GET_CASE_URL).to_return(body: FILTERS_JSON_STRING)
  end
  
  subject { Filter }
  context ".query" do
    before do
      @filters = subject.query()
    end
    
    it "returns all 10 filters" do
      @filters.class.should == Array
      @filters.length.should == 10
    end
    
    it "returns an Array of Case objects" do
      @filters.each do |c|
        c.class.should == Filter
      end
    end
  end
  
  context ".new" do
    before do
      @filter = subject.new(FILTER_HASH)
    end
    
    it "takes a hash and returns its id via its getter method" do
      @filter.id.should == "2026388"
    end
    
    it "takes a hash and attributes can be accessed via method missing" do
      @filter.name.should == "Inbox"
      @filter.active.should == true
    end
  end
end