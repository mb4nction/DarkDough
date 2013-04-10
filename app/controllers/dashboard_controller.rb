class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    @title = 'Dashboard - Budget 24/7'
    @goals = current_user.goals
    @budgets = current_user.budgets
    @spending_transactions = current_user.transactions.spending_transactions
    @transactions_by_month = current_user.transactions.transactions_by_month

		@personal_info = {}
		@personal_info[:name] = "#{current_user.first_name} #{current_user.last_name}"
		@personal_info[:location] = current_user.country
=begin
		
		@personal_info[:taken] = tests.last.created_at.strftime("%d, %B, %Y")
		@personal_info[:next] = (tests.last.created_at+20.day).strftime("%d, %B, %Y")
		@personal_info[:next_comment] = "You can be taken at next test in 20 days."
		@personal_info[:picture] = "/assets/person.png"
		@personal_info[:first_job] = tests.where(:question_id=>'_c__how_old_were_you').first.answer
		@personal_info[:age] = user_age
		@personal_info[:retirement_age] = tests.where(:question_id=>'_c__at_what_age').first.answer
		@personal_info[:life_expectancy] = 90
=end
		@budgets = {
			:_total => {
				:_caption=>'Total',
				:_percent=>'60%',
				:_bgcolor=>'#8fc14f',
				:_cost1=>'2,500',
				:_cost2=>'400',
				:_cost2_color=>'green'
			},
			:_interest_income => {
				:_caption=>'Interest income',
				:_percent=>'0%',
				:_bgcolor=>'#8fc14f',
				:_cost1=>'3,000',
				:_cost2=>'3,000',
				:_cost2_color=>'green'
			},
			:_paycheck => {
				:_caption=>'Paycheck',
				:_percent=>'30%',
				:_bgcolor=>'#8fc14f',
				:_cost1=>'1,500',
				:_cost2=>'1,050',
				:_cost2_color=>'green'
			},
			:_gas_n_fuel => {
				:_caption=>'Gas & Fuel',
				:_percent=>'100%',
				:_bgcolor=>'#f97648',
				:_cost1=>'50',
				:_cost2=>'-16',
				:_cost2_color=>'red'
			},
			:_coffee_shops => {
				:_caption=>'Coffee Shops',
				:_percent=>'90%',
				:_bgcolor=>'#8fc14f',
				:_cost1=>'70',
				:_cost2=>'8',
				:_cost2_color=>'green'
			},
			:_groceries => {
				:_caption=>'Groceries',
				:_percent=>'100%',
				:_bgcolor=>'#f97648',
				:_cost1=>'250',
				:_cost2=>'-70',
				:_cost2_color=>'red'
			},
			:_credit_card_payment => {
				:_caption=>'Credit Card Payment',
				:_percent=>'0%',
				:_bgcolor=>'#8fc14f',
				:_cost1=>'20',
				:_cost2=>'20',
				:_cost2_color=>'green'
			}
		}
  end
end
