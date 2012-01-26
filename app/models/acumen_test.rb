class AcumenTest < ActiveRecord::Base
  attr_accessible :code, :result

  belongs_to :user
  has_many :answers
end
