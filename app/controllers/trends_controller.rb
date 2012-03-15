class TrendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @top_merchant = current_user.top_merchant
    @most_purchased  = current_user.most_purchased
    @most_expensive = current_user.transactions.find(:all, :order => 'amount DESC').first

    @spending_transactions = current_user.transactions.spending_transactions.
                                          search(params[:trends_start], params[:trends_end], 'spending')
    @income_transactions = current_user.transactions.by_category('Income').
                                        search(params[:trends_start], params[:trends_end], 'income')

    @income_amount = current_user.transactions.by_category('Income').find_amount(params[:trends_start], params[:trends_end])
    @spending_amount = current_user.transactions.spending_transactions.find_amount(params[:trends_start], params[:trends_end])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
