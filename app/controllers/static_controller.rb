class StaticController < ApplicationController
  before_filter :authenticate_user!, :only => :help_create_account

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
end
