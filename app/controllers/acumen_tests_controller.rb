class AcumenTestsController < ApplicationController
  before_filter :authenticate_user!

  def show
  end

  def new
    @user = current_user
    @acumen_test = AcumenTest.new
  end

  def create
    @acumen_test = AcumenTest.new(params[:acumen_test])
    if @acumen_test.valid?
      @acumen_test.save
      redirect_to root_path

    else
      render :new
    end
  end

  def edit
    @acumen_test = AcumenTest.first
  end

  def update
  end
end
