class Transaction < ActiveRecord::Base
  belongs_to :user

  validates :category, :amount, :presence => true
  validates :amount, :numericality => true
end
