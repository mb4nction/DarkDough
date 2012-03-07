class TrendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @top_merchant = current_user.top_merchant
    @most_purchased  = current_user.most_purchased
    @most_expensive = current_user.transactions.find(:all, :order => "amount DESC").first

    @spending_transactions = current_user.transactions.spending_transactions
    @income_transactions = current_user.transactions.by_category("Income")
    @income_amount = current_user.total_income
    @spending_amount = current_user.spending_amount
  end
end
