class LoginController < ApplicationController
  def new
  end

  def create
	user = User.where(email: params[:email]).first
	if user && user.authenticate(params[:password])
	  login_user!(user)
	else
	  flash[:notice] = "Invalid email or password"
	  redirect_to login_path
	end
  end

  def destroy
  	session[:user_id] = nil
  	session[:user_email] = nil
  	flash[:notice] = "Logged out successfully"
 	redirect_to root_path
  end

  private

	def login_user!(user)
	  session[:user_email] = user.email
	  session[:user_id] = user.id
	  flash[:notice] = "Welcome, you're now logged in"
	  redirect_to root_path
	end

end
