class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  validates :category, :amount, :description, :presence => true
  validates :amount, :numericality => true

  CATEGORIES = YAML.load_file("#{Rails.root}/config/categories.yml")
end
