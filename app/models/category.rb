class Category < ActiveRecord::Base
  has_many :budgets
  
  validates :category_type, :inclusion => { :in => %w(income spending) }
end
