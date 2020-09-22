class SessionsController < ApplicationController
  def new
  end

  # login
  def create
    if user = User.authenticate_with_credentials(params[:email],params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end

  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
