require 'spec_helper'

describe PicsController do

  before do
    DatabaseCleaner.clean
  end

  describe "GET #index" do
    it "populates @pics" do
      get :index
      assigns(:pics).size.should == Pic.all.size
    end
  end

  describe "GET #map" do
    it "populates @pics" do
      get :index
      assigns(:pics).size.should == Pic.all.size
    end
  end

  describe "GET #show" do
    it "assigns the requested pic to @pic" do
      pic = FactoryGirl.create(:pic)
      get :show, id: pic
      assigns(:pic).should eq(pic)
    end

    it "renders #show template" do
      get :show, id: FactoryGirl.create(:pic)
      response.should render_template :show
    end
  end

  describe "GET #new" do
  end

  describe "POST #create" do
  end

  describe "PUT #update" do
  end

  describe "DELETE #index" do
  end

end