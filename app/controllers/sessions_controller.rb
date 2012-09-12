class SessionsController < ApplicationController

  # GET /sessions/new
  def new
    redirect_to(root_url, :notice => "already logged in.") if current_user
  end

  # POST /sessions
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  # DELETE /sessions/:id
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
