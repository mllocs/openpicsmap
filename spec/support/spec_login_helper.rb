module SpecLoginHelper   

  def find_or_create_user
    User.count == 0 ? FactoryGirl.create(:user) : User.first
  end

  def request_login
    # post_via_redirect login_path, 'email' => user.email, 'password' => "secret"
    user = find_or_create_user
    visit login_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => "secret"
    click_button "Log In"
    page.should have_content("Logout")
  end

  def controller_login
    user = find_or_create_user
    request.session[:user_id] = user.id
  end

  def redirect_to_login
    redirect_to(login_path)
  end

end