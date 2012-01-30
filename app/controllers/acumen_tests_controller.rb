class AcumenTestsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @acumen_test = AcumenTest.new
    @acumen_test.answers.build
  end

  def create
    @acumen_test = current_user.acumen_tests.build params[:acumen_test]
    if @acumen_test.save
      render :show
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
