class Category < ActiveRecord::Base
  has_many :budgets
  
  scope :income, where(:category_type => 'income')
  scope :spending, where(:category_type => 'spending')
  
  validates :category_type, :inclusion => { :in => %w(income spending) }
end
