class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => "Profile updated"
    else
      render 'edit'
    end
  end
end
