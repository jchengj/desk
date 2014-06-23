require 'spec_helper'
require 'fixtures/case_helper'

describe Case do
  CASE_GET_URL = "https://joseph.desk.com/api/v2/filters/2026388/cases"
  CASE_POST_URL = "https://joseph.desk.com/api/v2/cases/1"
  
  before do
    stub_request(:get, CASE_GET_URL).to_return(body: CASES_JSON_STRING)
  end
  
  subject { Case }
  context ".query" do
    before do
      @cases = subject.query(2026388)
    end
    
    it "returns all cases for filer 2026388" do
      @cases.class.should == Array
      @cases.length.should == 2  
    end
    
    it "returns an Array of Case objects" do
      @cases.each do |c|
        c.class.should == Case
      end
    end
  end
  
  context ".new" do
    it "takes a hash and attributes can be accessed via method missing" do
      c = subject.new(CASE_HASH)
      c.id.should == 1
      c.status.should == "open"
      c.type.should == "email"    
    end
  end
  
  context ".update" do
    it "should add a new label to the case" do  
      expect_any_instance_of(OAuth::AccessToken).to receive(:post)
        .with(CASE_POST_URL, 
              {labels: "test"}.to_json, 
              { 'Accept'=>'application/json', 'Content-Type' => 'application/json', "x-http-method-override" => "PATCH" })
        .and_return(double(code: 200, body: CASE_HASH.to_json))
        
      subject.update(1, {labels: "test"})
    end
  end
end
