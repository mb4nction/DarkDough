class StaticController < ApplicationController
  before_filter :authenticate_user!, only: :help_create_account
  before_filter :redirect_signed_in_user, only: 'home'

  layout 'public'

  def home
    @title = "Home"
  end

  def about
    @title = "About"
  end

  def how_it_works
    @title = "How it works"
  end

  def faq
    @title = "FAQ"
  end

  def terms_of_use
    @title = "Terms of use"
  end

  def help_create_account
    @title = "Help create account"
  end

  private

  def redirect_signed_in_user
    if current_user
      redirect_to dashboard_path
    end
  end
end
