class AcumenTest < ActiveRecord::Base
  attr_accessible :code, :result
  validates :code, :presence => true

  belongs_to :user
  has_many :answers

  TESTS = [ :qualitative, :quantitative, :cash_flow ]
end
