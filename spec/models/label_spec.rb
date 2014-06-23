require 'spec_helper'
require 'fixtures/label_helper'

describe Label do
  LABEL_URL = "https://joseph.desk.com/api/v2/labels"
  LABEL_HEADER = { 'Accept'=>'application/json', 'Content-Type' => 'application/json' }
  
  before(:each) do
    stub_request(:get, LABEL_URL).to_return(body: LABELS_JSON_STRING)
  end
  
  subject { Label }
  context ".query" do
    before do
      @labels = subject.query()
    end
    
    it "returns all labels" do
      @labels.class.should == Array
      @labels.length.should == 11
    end
    
    it "returns an Array of Label objects" do
      @labels.each do |l|
        l.class.should == Label
      end
    end
  end
  
  context ".new" do
    it "takes a hash and attributes can be accessed via method missing" do
      label = subject.new(LABEL_HASH)
      label.id.should == 1832423
      label.name.should == "Abandoned Chats"
      label.description.should == "Abandoned Chats"    
    end
  end
  
  context ".create" do
    it "should add a new label to the case" do
      expect_any_instance_of(OAuth::AccessToken).to receive(:post)
        .with(LABEL_URL, {name: "test", description: "test"}.to_json, LABEL_HEADER)
        .and_return(double(code: 200, body: LABEL_HASH.to_json))      
      subject.create({name: "test", description: "test"})
    end
  end
end
