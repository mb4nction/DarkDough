class AcumenTest < ActiveRecord::Base
  attr_accessible :code, :result, :answers_attributes

  belongs_to :user
  has_many :answers

  accepts_nested_attributes_for :answers
end
