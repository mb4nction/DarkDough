class TrendsController < ApplicationController
  before_filter :authenticate_user!
  require 'active_support/core_ext/date/conversions'

  def index
    @top_merchant = current_user.top_merchant
    @most_purchased  = current_user.most_purchased
    @most_expensive = current_user.transactions.find(:all, :order => 'amount DESC').first

    @spending_transactions = current_user.transactions.spending_transactions.search(params[:trends_start], params[:trends_end], 'spending')
    @income_transactions = current_user.transactions.by_category('Income').search(params[:trends_start], params[:trends_end], 'income')

    @spending_by_category_json = {
      :name => 'flare', :children => category_listed(@spending_transactions).map{ |category, amount| {
        :name => category, :children => [{ :name => category, :size => amount }] }}}


    @spending_over_time_json = {
      :name => 'flare', :children => time_listed(@spending_transactions).map{ |month, amount| {
        :name => Date::MONTHNAMES[month.to_i], :children => [{ :name => Date::MONTHNAMES[month.to_i], :size => amount }] }}}

    @spending_by_merchant_json = {
      :name => 'flare', :children => merchant_listened(@spending_transactions).map{ |description, amount| {
        :name => description, :children => [{ :name => description, :size => amount }] }}}

    @income_by_category_json = {
      :name => "flare", :children => category_listed(@income_transactions).map { |category, amount| {
          :name => category, :children => [{ :name => category, :size => amount.to_f}] }}}

    @income_over_time_json = {
      :name => 'flare', :children => time_listed(@income_transactions).map{ |month, amount| {
        :name => Date::MONTHNAMES[month.to_i], :children => [{ :name => Date::MONTHNAMES[month.to_i], :size => amount }] }}}

    @income_by_merchant_json = {
      :name => 'flare', :children => merchant_listened(@income_transactions).map{ |description, amount| {
        :name => description, :children => [{ :name => description, :size => amount }] }}}

    @income_amount = current_user.transactions.by_category('Income').find_amount(params[:trends_start], params[:trends_end])
    @spending_amount = current_user.transactions.spending_transactions.find_amount(params[:trends_start], params[:trends_end])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def category_listed(transactions)
    hash_array = []
    categories = transactions.map{ |transaction| transaction.category }.uniq
    categories.each do |category|
      amounts = []
      transactions.each do |transaction|
        amounts << transaction.amount if transaction.category == category
      end
      hash_array << amounts.sum
      hash_array << category
    end
    hash_array = hash_array.reverse
    Hash[*hash_array]
  end

  def time_listed(transactions)
    hash_array = []
    months = transactions.map{ |transaction| transaction.created_at.month }.uniq
    months.each do |month|
      amounts = []
      transactions.each do |transaction|
        amounts << transaction.amount.to_i if transaction.created_at.month == month
      end
      hash_array << amounts.sum
      hash_array << month.to_s
    end
    hash_array = hash_array.reverse
    Hash[*hash_array]
  end

  def merchant_listened(transactions)
    hash_array = []
    descriptions = transactions.map{ |transaction| transaction.description }.uniq
    descriptions.each do |description|
      amounts = []
      transactions.each do |transaction|
        amounts << transaction.amount.to_i if transaction.description == description
      end
      hash_array << amounts.sum
      hash_array << description
    end
    hash_array = hash_array.reverse
    Hash[*hash_array]
  end
end
