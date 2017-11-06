class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]
  before_action :require_valid_user,  only: [:edit, :update, :destroy]

  def show
    redirect_to user_posts_path(params[:id])
  end

  def new
    @user = User.new
    redirect_to user_posts_path(current_user) if current_user
  end

  def create
    @user = User.new(safe_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to edit_user_path(@user)
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end
  end

  def update
    if current_user.update(safe_user_params)
      flash[:success] = "Successfully updated your profile."
      redirect_to user_posts_path(current_user)
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  private

  def safe_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :dob, :gender, :college, :hometown, :currently_lives, :phone, :words_live, :about_me)
  end
end
