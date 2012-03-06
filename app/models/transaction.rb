class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  validates :category, :amount, :description, :presence => true
  validates :amount, :numericality => true

  CATEGORIES = YAML.load_file("#{Rails.root}/config/categories.yml")

  scope :by_category, lambda { |q| {:conditions => ["category like :q", {:q => "%#{q}%"}]} }
  scope :spending_transactions, lambda { where("category != ?", "income") }

  def amounts_sum(category)
    by_category(category).map(&:amount).sum
  end
end
