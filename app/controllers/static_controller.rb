class StaticController < ApplicationController
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
end
