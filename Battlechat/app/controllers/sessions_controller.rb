class SessionsController < ApplicationController
  def new
  end

  def create
    #find the user by their email
    user = User.where(email: params[:user][:email]).first
    if user && user.authenticate(params[:user][:password])
      cookies.permanent[:auth_token] = user.auth_token
     redirect_to '/battlechat'
    else
      flash[:notice] = "Invalid email or password"
      redirect_to '/'
    end
  end

  def destroy 
    cookies.delete(:auth_token)
    GameChannel.on_unsubscribe
    flash[:notice] = "Successfully logged out!"
    redirect_to '/'
  end
end
