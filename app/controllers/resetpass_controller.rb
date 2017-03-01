class ResetpassController < ApplicationController
  before_action :authenticate_user!


  def edit
    @user = current_user
    @password = @user.password
  end

  def update_password
    @user = current_user
    if @current_password == @user.password
      @user.update(new_password_params)
    end
    if @user.update(user_params)

      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def new_password_params
    params.require(:user).permit(:password,
                                 :password_confirmation)
  end
  def user_params
   params.require(:user).permit(:password, :password_confirmation)
 end

end
