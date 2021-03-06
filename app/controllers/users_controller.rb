class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_valid_user,  only: [:edit, :update, :destroy]

  def show
    redirect_to user_path
  end

  def new
    @user = User.new
    @user.build_profile
    redirect_to user_posts_path(current_user) if current_user
  end

  def create
    @user = User.create(safe_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to edit_user_profile_path(@user)
    else
      flash.now[:error] = "Failed to Create User!"
      @user.build_profile
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
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :id,
                                 {profile_attributes: [:user_id,
                                                       :college,
                                                       :hometown,
                                                       :location,
                                                       :phone,
                                                       :motto,
                                                       :about,
                                                       :gender,
                                                       :dob_day,
                                                       :dob_month,
                                                       :dob_year] })
  end
end
