module SpecLoginHelper

  def find_or_create_user
    User.count == 0 ? FactoryGirl.create(:user) : User.first
  end

  def user_login
    user = find_or_create_user
    visit "/login"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => "secret"
    click_button "Log In"
    page.should have_content("Logout")
    user
  end

  def controller_login
    user = find_or_create_user
    request.session[:user_id] = user.id
  end

  def redirect_to_login
    redirect_to(login_path)
  end
end