class AcumenTestsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @acumen_test = current_user.acumen_tests.first
  end

  def new
    @acumen_test = AcumenTest.new
    Answer::QUESTIONS.sort_by{ |k,v| k }.each do |code, title|
      @acumen_test.answers.build :answer_code => code, :question_title => title
    end
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
    @acumen_test = current_user.acumen_tests.last
    @test_answers = @acumen_test.answers.find(:all, :order => 'answer_code')
  end

  def update
  end
end
