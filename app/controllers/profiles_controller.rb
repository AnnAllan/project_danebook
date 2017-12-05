class ProfilesController < ApplicationController

  def create
    @profile = Profile.new(safe_user_params)
    if @profile.save
      sign_in(@user)
      flash[:success] = "Account created"
      redirect_to user_profile_path(current_user)
    else
      flash.now[:error] = "Account not created"
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    puts "made it to profile edit action+++++++++++++++++++++++++"
    @user = User.find(params[:user_id])
    @profile = User.find(params[:user_id])
  end

  def update
    @profile = current_user.profile
    if @profile.update(safe_user_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(current_user)
    else
      flash.now[:failure] = "Profile was not updated"
      render :edit
    end
  end

  def safe_user_params
    params.require(:profile).permit(:id, :college, :hometown, :location, :phone, :motto, :about)
  end


end
