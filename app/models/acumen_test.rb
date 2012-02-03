class AcumenTest < ActiveRecord::Base
  include AcumenTestHelper

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

  # def calculate_acumen_test
  # end

  def qualitative_test_finished?
    !(test_answers('t1').map(&:result).include?(nil) || test_answers('t1').map(&:result).include?(""))
  end

  # def quantitative_result
  # end
  #
  # def cash_flow_result
  # end

  def test_answers(code)
    self.answers.answers_by_code(code)
  end

  def goals_and_aspirations
    gaa_array = ["t1q46", "t1q47", "t1q48", "t1q49", "t1q50", "t1q51"]
    result_array = []
    gaa_array.each do |arr|
      test_answers('t1').find{ |answer| result_array << answer.result if (answer.code == arr) }
    end
    res = result_array.map(&:to_i).sum
    case res
      when 0
        result = "-2"
      when 1
        result = "-1"
      when 2
        result = "1"
      when 3,4,5
        result = "2"
    end
    return result.to_i
  end

  def traditions
    answer_result = test_answers('t1').find_by_code("t1q56").result
    case answer_result.to_i
    when 0
      result = "-2"
    when 1
      result = "-1"
    when 2
      result = "1"
    when 3,4,5
      result = "2"
    end
    return result.to_i
  end

  def financial_priorities_algorithm(res)
    case res
    when nil
      result = "0"
    when "1"
      result = 2
    when "2"
      result = 1
    when "3"
      result = 0.5
    end
    return result
  end

  def legacy
    answer_result = test_answers('t1').find_by_code("t1q53").result
    financial_priorities_algorithm(answer_result)
  end

  def lifestyle
    answer_result = test_answers('t1').find_by_code("t1q54").result
    financial_priorities_algorithm(answer_result)
  end

  def thrift
    answer_result = test_answers('t1').find_by_code("t1q55").result
    return 0
  end

  def qualitative_count
    first_test_answers = test_answers('t1')
    result = {:worry => worry_count(first_test_answers),
              :self_interest => self_interest_count(first_test_answers),
              :discipline => discipline_count(first_test_answers),
              :motivation => motivation_count(first_test_answers),
              :thrill_seeking => thrill_seeking_count(first_test_answers)}
  end

  def worry_count(test_answers)
    worry_array = []
    Answer::WORRY.each do |code|
      test_answers.find{ |answer| worry_array << answer.result if (answer.code == code) }
    end
    worry_result = worry_array.compact.map(&:to_i).sum
  end

  def self_interest_count(test_answers)
    self_interest_array = []
    Answer::SELF_INTEREST.each do |code|
      test_answers.find{ |answer| self_interest_array << answer.result if (answer.code == code) }
    end
    self_interest = self_interest_array.compact.map(&:to_i).sum

    self_interest_deduct_array = []
    Answer::SELF_INTEREST_DEDUCT.each do |code|
      test_answers.find{ |answer| self_interest_deduct_array << answer.result if (answer.code == code) }
    end
    self_interest_deduct = self_interest_deduct_array.compact.map(&:to_i).sum
    self_interest_result = self_interest - self_interest_deduct + goals_and_aspirations + lifestyle - legacy + thrift
  end

  def discipline_count(test_answers)
    discipline_array = []
    Answer::DISCIPLINE.each do |code|
      test_answers.find{ |answer| discipline_array << answer.result if (answer.code == code) }
    end
    discipline_result = discipline_array.compact.map(&:to_i).sum
  end

  def motivation_count(test_answers)
    motivation_array = []
    Answer::MOTIVATION.each do |code|
      test_answers.find{ |answer| motivation_array << answer.result if (answer.code == code) }
    end
    motivation = motivation_array.compact.map(&:to_i).sum

    motivation_deduct_array = []
    Answer::MOTIVATION_DEDUCT.each do |code|
      test_answers.find{ |answer| motivation_deduct_array << answer.result if (answer.code == code) }
    end
    motivation_deduct = motivation_deduct_array.compact.map(&:to_i).sum
    motivation_result = motivation - motivation_deduct + traditions + legacy - lifestyle + thrift
  end

  def thrill_seeking_count(test_answers)
    thrill_seeking_array = []
    Answer::THRILL_SEEKING.each do |code|
      test_answers.find{ |answer| thrill_seeking_array << answer.result if (answer.code == code) }
    end
    thrill_seeking = thrill_seeking_array.compact.map(&:to_i).sum

    thrill_seeking_deduct_array = []
    Answer::THRILL_SEEKING_DEDUCT.each do |code|
      test_answers.find{ |answer| thrill_seeking_deduct_array << answer.result if (answer.code == code) }
    end
    thrill_seeking_deduct = thrill_seeking_deduct_array.compact.map(&:to_i).sum
    thrill_seeking_result = thrill_seeking - thrill_seeking_deduct
  end
end
