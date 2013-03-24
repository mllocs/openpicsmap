class UsersController < ApplicationController

  def new
    redirect_to(root_url, :notice => "No more users allowed.") if User.all.size >= User::MAX_USERS
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

end
