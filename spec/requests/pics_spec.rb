require 'spec_helper'

describe "Pics pages" do

  before do
    DatabaseCleaner.clean
  end

  describe "Pics Gallery page" do

    context "logged out" do

      it "displays pics titles" do
        visit "/pics"
        Pic.all.each do |p|
          page.should have_content(p.title)
        end
      end

      it "displays pics links to show and map" do
        visit "/pics"
        Pic.all.each do |p|
          page.should have_selector "a[href$='#{pic_path(p)}']"
          page.should have_link("Map", :href => map_pics_path(:pic_id => p.id))
        end
      end

      it "does not show Edit and Delete links" do
        FactoryGirl.create(:pic)
        visit "/pics"
        page.should_not have_link("Edit")
        page.should_not have_link("Delete")
      end
    end

    context "logged in" do
      it "shows Edit and Delete links" do
        FactoryGirl.create(:pic)
        login
        visit "/pics"
        page.should have_link("Edit")
        page.should have_link("Delete")
      end
    end
  end

  describe "New Pic page" do 

    context "logged out" do
      it "kicks you out" do
        visit "/pics/new"
        current_path.should == "/login"
      end
    end

    context "logged in" do

      before :each do
        login
        visit "/pics/new"
      end

      it "let you create a pic with title and attached file" do
        attach_file "Image", "#{Rails.root.to_s}/spec/support/sample_photo.jpg"
        fill_in "Title", :with => "Test image"
        click_button "Create Pic"
        visit "/pics"
        Pic.find_by_title("Test image").should_not be_nil
        page.should have_content("Test image")
      end
      
      it "give you an error if you dont provide title or attached file" do
        click_button "Create Pic"
        page.should have_content("Image can't be blank")
        page.should have_content("Title can't be blank")
      end
    end
  end

  describe "Delete Pic" do

    context "logged out" do
      it "should not be able to delete pics" do
        FactoryGirl.create(:pic)
        pics_count = Pic.all.size
        delete pic_path(Pic.first)
        Pic.all.size.should == pics_count
      end
    end

    context "logged in" do
    end
  end
end