class ProfilesController < ApplicationController
  layout 'dashboard'
  before_filter :set_user
  before_action :authenticate_user!, except: :show

  def edit
    if @user
      render
    else
      redirect_to root_path, notice: "Profile not found!"
    end
  end

  def update
    if @user.update user_params
      redirect_to edit_profile_path, notice: "Your profile has been updated."
    else
      render 'edit'
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :login, :email,
      profile_attributes: [
        :id, :user_id, :full_name, :ic_number, :phone_number
      ])
  end
end
