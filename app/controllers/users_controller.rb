class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      rediect to '/'
    else
      rediect to '/signup'
    end
  end


  private

  def user_params
    paras.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
