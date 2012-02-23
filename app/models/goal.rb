class Goal < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :accounts

  attr_accessible :title, :category, :amount, :contribution, :planned_date, :user_id, :account_ids

  GOAL_CATEGORIES = ["Babies and Kids", "Bill and Taxes", "Electronics", "Gifts and Shopping",
                     "Wedding", "Other", "Furniture"]

  validates :title, :category, :amount, :contribution, :planned_date, :presence => true
  validates :category, :inclusion => { :in => GOAL_CATEGORIES }
  validates :amount, :numericality => true

  def available_balance
    accounts.map{ |account| account.amount}.sum.to_f
  end

  def todays_balance
    self.amount - available_balance
  end
end
