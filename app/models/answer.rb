class TestAnswer < ActiveRecord::Base
  attr_accessible :question, :answer, :answer_number

  belongs_to :acumen_test
end
