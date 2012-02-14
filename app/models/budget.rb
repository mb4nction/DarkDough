class Budget < ActiveRecord::Base
  PERIODS = %w(1 3)

  belongs_to :user

  validates :category, :amount, :period, :presence => true
  validates :amount, :numericality => true

  scope :income, where(:category => 'income')
  scope :spending, lambda { where("category != ?", "income") }
end
