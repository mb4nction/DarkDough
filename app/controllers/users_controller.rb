class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_account

  def show
    @title = 'Profile - Budget 24/7'
    params[:user] ? @user = current_user.update_attributes(params[:user]) : @user = current_user
    @accounts = current_user.accounts
    respond_to do |format|
      format.html
      format.js
    end
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

  private

  def check_account
    redirect_to '/accounts/new' unless current_user.accounts.any?
  end
end
