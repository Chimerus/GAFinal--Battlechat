class SessionsController < ApplicationController
  def new
  end

  def create
    #find the user by their email
    # TODO eliminate the permanent cookies
    user = User.where(email: params[:user][:email]).first
    if user && user.authenticate(params[:user][:password])
      cookies.permanent[:auth_token] = user.auth_token
     redirect_to '/battlechat'
    else
      flash[:notice] = "Invalid email or password"
      redirect_to '/'
    end
  end

  # cleanup
  def destroy 
    cookies.delete(:auth_token)
    session.clear
    GameChannel.on_unsubscribe
    RoomChannel.on_unsubscribe
    flash[:notice] = "Successfully logged out!"
    redirect_to '/'
  end
end
