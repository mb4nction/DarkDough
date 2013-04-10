class Goal < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :accounts
	has_many :goal_details

  attr_accessible :title, :category, :amount, :current_amount, :contribution, :planned_date, :user_id, :account_ids, :finished

  GOAL_PREDEFINED_CATEGORIES = ["Family/Personal Vacation", "School Tuition", "Save for an emergency",
                                "Mortgage Contribution", "Buy Home", "Build Home", "Investment Opportunity",
                                "Safety Net", "Business Capital", "Wedding", "Anniversary/Birthday",
                                "Charitable Giving", "Car", "House Rent", "Repay Debt", "Create Custom Goal"]

  GOAL_CATEGORIES = ["Babies and Kids", "Bill and Taxes", "Electronics", "Gifts and Shopping",
                     "Wedding", "Other", "Furniture"]
	
	GOAL_CATEGORIES_EXT = {
		:_vacation => {:title=>"Vacation", :image=>"icon-goal-1.png", :mov_type=>3, :amount_needed=>'1454.81'},
		:_tutition => {:title=>"Tutition", :image=>"icon-goal-2.png", :mov_type=>0, :amount_needed=>'1532'},
		:_mortgage_contribution => {:title=>"Mortgage contribution", :image=>"icon-goal-3.png", :mov_type=>3, :amount_needed=>'3000'},
		:_buy_home => {:title=>"Buy home", :image=>"icon-goal-4.png", :mov_type=>5, :amount_needed=>'50000'},
		:_build_home => {:title=>"Build home", :image=>"icon-goal-5.png", :mov_type=>5, :amount_needed=>'100000'},
		:_investment_opportunity => {:title=>"Investment opportunity", :image=>"icon-goal-6.png", :mov_type=>0, :amount_needed=>'4000'},
		:_safety_net => {:title=>"Safety net", :image=>"icon-goal-7.png", :mov_type=>1, :amount_needed=>'2000'},
		:_business_capital => {:title=>"Business Capital", :image=>"icon-goal-8.png", :mov_type=>5, :amount_needed=>'3000'},
		:_wedding => {:title=>"Wedding", :image=>"icon-goal-9.png", :mov_type=>2, :amount_needed=>'2000'},
		:_anniversary_or_birthday => {:title=>"Anniversary or birthday", :image=>"icon-goal-10.png", :mov_type=>3, :amount_needed=>'1000'},
		:_repay_debt => {:title=>"Repay debt", :image=>"icon-goal-11.png", :mov_type=>0, :amount_needed=>'2000'},
		:_charitable_giving => {:title=>"Charitable giving", :image=>"icon-goal-12.png", :mov_type=>0, :amount_needed=>'1200'},
		:_car => {:title=>"Car", :image=>"icon-goal-13.png", :mov_type=>4, :amount_needed=>'5000'},
		:_house_rent => {:title=>"House rent", :image=>"icon-goal-14.png", :mov_type=>0, :amount_needed=>'2400'}
	}

  validates :title, :category, :amount, :current_amount, :contribution, :planned_date, :presence => true
  #validates :category, :inclusion => { :in => GOAL_PREDEFINED_CATEGORIES | GOAL_CATEGORIES }
  validates :amount, :numericality => true
  validates :current_amount, :numericality => true

  def available_balance
    #accounts.map{ |account| account.amount}.sum.to_f
		15000
  end

  def todays_balance
    self.amount - available_balance
  end

  def can_be_finished?
    (todays_balance <= 0) && (self.finished == false)
  end

  def finished?
    self.finished == true
  end
end

