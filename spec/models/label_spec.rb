require 'spec_helper'
require 'fixtures/label_helper'

describe Label do
  GET_URL = "https://joseph.desk.com/api/v2/labels"
  
  before do
    stub_request(:get, GET_URL).to_return(body: LABELS_JSON_STRING)
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
      c = subject.new(LABEL_HASH)
      c.id.should == 1832423
      c.name.should == "Abandoned Chats"
      c.description.should == "Abandoned Chats"    
    end
  end
  
  context ".create" do
    it "should add a new label to the case" do
      subject.should_receive(:post).with("labels", {name: "test", description: "test"}).and_return({})
      subject.create({name: "test", description: "test"})
    end
  end
end
