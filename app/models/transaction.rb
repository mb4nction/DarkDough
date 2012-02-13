class Transaction < ActiveRecord::Base
  belongs_to :user

  validates :category, :amount, :presence => true
  validates :amount, :numericality => true

  CATEGORIES = YAML.load_file("#{Rails.root}/config/categories.yml")
end
