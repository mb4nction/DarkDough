class AcumenTest < ActiveRecord::Base
  attr_accessible :code, :result, :answers_attributes

  belongs_to :user
  has_many :answers

  accepts_nested_attributes_for :answers

  def finished?
    finished ? "finished" : "not finished yet"
  end

  def is_finished?
    !(self.answers.map(&:result).include?(nil) || self.answers.map(&:result).include?(""))
  end

  def finish_it!
    if self.is_finished?
      self.finished = true
      self.save
    else
      self.finished = false
      self.save
    end
  end

  def qualitative_result
    first_test_count(test_answers)
  end

  def quantitative_result
  end

  def cash_flow_result
  end

  def test_answers(code)
    self.answers.answers_by_code(code)
  end

  def first_test_count(test_answers)
    results = test_answers('t1').sort_by(&:code).map(&:result)
    worry = ""
    self_interest = ""
    discipline = ""
    motivation = ""
    thrill_seeking = ""
    result = {:worry => "#{worry}",
              :self_interest => "#{self_interest}",
              :discipline => "#{discipline}",
              :motivation => "#{motivation}",
              :thrill_seeking => "#{thrill_seeking}"}
    return result
  end
end
