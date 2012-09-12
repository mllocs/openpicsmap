require 'spec_helper'

describe "Pics requests" do

  describe "Gallery page" do

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
          page.should have_css("a[href=#{pic_path(p)}]") # page.should have_selector "a[href$='#{pic_path(p)}']"
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
      before do
        request_login
        @pic = FactoryGirl.create(:pic)
      end

      it "shows Edit and Delete links" do
        visit "/pics"
        within "div.pic" do
          page.should have_link("Edit")
          page.should have_link("Delete")
        end
      end

      it "should be able to delete pics" do
        visit "/pics"
        expect { find("#pic_#{@pic.id}").find("a.delete").click }.to change(Pic, :count).by(-1)
      end
    end
  end

  describe "New pic page" do 

    before do
      request_login
    end

    it "let you create a pic with title and attached file" do
      visit "/pics/new"
      attach_file "Image", "#{Rails.root.to_s}/spec/support/sample_photo.jpg"
      fill_in "Title", :with => "Test image"
      click_button "Create Pic"
      visit "/pics"
      Pic.find_by_title("Test image").should_not be_nil
      page.should have_content("Test image")
    end
    
    it "give you an error if you dont provide title or attached file" do
      visit "/pics/new"
      click_button "Create Pic"
      page.should have_content("Image can't be blank")
      page.should have_content("Title can't be blank")
    end
  end
end