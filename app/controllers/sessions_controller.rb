class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
        flash[:success] = "You have signed in"
      else
        sign_in(@user)
        flash[:success] = "You have signed in"
      end
      flash[:success] = "You've been successfully signed in"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "We couldn't sign you in"
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've been successfully signed"
    redirect_to root_path
  end
end
