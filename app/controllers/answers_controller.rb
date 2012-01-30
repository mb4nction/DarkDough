class AnswersController < ApplicationController
  before_filter :authenticate_user!

  def show
    # @answer = Answer.find params[:id]
    # @acumen_test = current_user.acumen_tests.first
  end

  def new
    # @acumen_test = current_user.acumen_tests.first
    # @answer = Answer.new
  end

  def update
  end

  def create
    # @acumen_test = current_user.acumen_tests.first
    # @answer = @acumen_test.answers.build params[:answers]
    #
    # if @answer.valid?
    #   @answer.save
    #   render :show, :notice => "Success"
    # else
    #   render :new
    # end
  end

  def edit
  end

end
