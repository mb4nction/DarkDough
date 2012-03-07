class TrendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @top_merchant = current_user.top_merchant
    @most_purchased  = current_user.most_purchased
    @most_expensive = current_user.transactions.find(:all, :order => "amount DESC").first

    @spending_transactions = current_user.transactions.spending_transactions
    @income_transactions = current_user.transactions.by_category("Income")
  end
end
