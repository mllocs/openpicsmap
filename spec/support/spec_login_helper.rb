module SpecLoginHelper   

  def login
    user = User.count == 0 ? FactoryGirl.create(:user) : User.first

    # request.session[:user] = user.id
    # post_via_redirect sessions_path, 'user[email]' => user.email, 'user[password]' => "secret"

    visit login_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => "secret"
    click_button "Log In"
    page.should have_content("Logout")
    
  end

end