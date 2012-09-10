require "spec_helper"

describe Pic do
  
  before do
    DatabaseCleaner.clean
  end
  
  it "has a valid factory" do
    pic = FactoryGirl.build(:pic).should be_valid
  end

  it "is invalid without a title" do
    pic = FactoryGirl.build(:pic, :title => nil).should_not be_valid
  end

  it "is invalid without an image" do
    pic = FactoryGirl.build(:pic, :image => nil).should_not be_valid
  end
  
end