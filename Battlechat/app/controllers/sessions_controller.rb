class SessionsController < ApplicationController
  def new
  end

  def create
    #find the user by their email
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      cookies.permanent[:auth_token] = user.auth_token
     redirect_to '/battlechat'
    else
      flash[:notice] = "Invalid email or password"
      redirect_to '/'
    end
  end

  def destroy 
    cookies.delete(:auth_token)
    flash[:notice] = "Successfully logged out!"
    redirect_to '/'

  end
end
