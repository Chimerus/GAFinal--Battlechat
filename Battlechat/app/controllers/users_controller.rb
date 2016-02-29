class UsersController < ApplicationController
  def index
    if current_user
      redirect_to '/battlechat'
    else
      render :index
    end
  end

  def new
  end

  def edit
     id = params[:id]
    @user = User.find(id)
  end

  def index
    if cookies.permanent[:auth_token]
      redirect_to '/battlechat'
    else
      render :index
    end
  end

  def update
    id = params[:id]
    @user = User.find(id)
    if @user.update_attributes(user_params)
      flash[:notice] = "Your account was successfully updated "
      redirect_to "/battlechat"
    else
       flash[:notice] = "Error: Please enter a password"
       redirect_to(:back)
     end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
      flash[:notice] = "Welcome to Battlechat "+@user.name+"!"
      redirect_to '/battlechat'
    else
      email = User.where(email: params['user']['email']).first
      if email 
        flash[:notice] = "That email is already used"
         redirect_to '/'
        elsif params['user']['password'].length < 6
          flash[:notice] = "Password is too short"
          redirect_to '/'          
        else
        flash[:notice] = "invalid email"
        redirect_to '/'
      end
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
