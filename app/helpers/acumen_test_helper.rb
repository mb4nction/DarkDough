module AcumenTestHelper
  def worry_test_resulting
    res = qualitative_result[:worry]
    case res.to_i
    when 30..44
      result =  "Exceptionally high"
    when 13..31
      result =  "Very high"
    when -12..12
      result =  "Average"
    when -31..-13
      result =  "Below average"
    when -44..-32
      result =  "Negligible"
    end
    return result
  end

  def motivation_test_resulting
    res = qualitative_result[:motivation]
    case res.to_i
    when 14..18
      result =  "Exceptionally high"
    when 8..13
      result =  "Very high"
    when -5..7
      result =  "Average"
    when -14..-6
      result =  "Below average"
    when -18..-15
      result =  "Negligible"
    end
    return result
  end


  def discipline_test_resulting
    res = qualitative_result[:discipline]
    case res.to_i
    when 14..18
      result =  "Exceptionally high"
    when 8..13
      result =  "Very high"
    when -5..7
      result =  "Average"
    when -14..-6
      result =  "Below average"
    when -18..-15
      result =  "Negligible"
    end
    return result
  end

  def self_interest_test_resulting
    res = qualitative_result[:self_interest]
    case res.to_i
    when 22..30
      result =  "Exceptionally high"
    when 11..21
      result =  "Very high"
    when -10..10
      result =  "Average"
    when -22..-11
      result =  "Below average"
    when -30..-23
      result =  "Negligible"
    end
    return result
  end

  def thrill_seeking_test_resulting
    res = qualitative_result[:thrill_seeking]
    case res.to_i
    when 15..22
      result =  "Exceptionally high"
    when 9..14
      result =  "Very high"
    when -6..8
      result =  "Average"
    when -15..-7
      result =  "Below average"
    when -22..-16
      result =  "Negligible"
    end
    return result
  end

  def set_user_group(test_result)
    case test_result
    when "Exceptionally high"
      user_group = "Livewires"
    when "Very high"
      user_group = "Sovereigns"
    when "Average"
      user_group = "Swashbucklers"
    when "Below average"
      user_group = "Adherents"
    when "Negligible"
      user_group = "Nihilists"
    end
    return user_group
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

  # cash flow calculations
  def apply_paye?
    self.answers.find_by_code('t3q03').result == "1"
  end

  def apply_income_tax?
    self.answers.find_by_code('t3q12').result == "1"
  end

  def income_count
    test_answers = self.test_answers('t3')
    result_array = []
    Answer::TOTAL_INCOME.each do |code|
      test_answers.find{ |answer| result_array << answer.result if (answer.code == code) }
    end
    result = apply_paye? ? result_array.compact.map(&:to_i).sum : result_array.compact.map(&:to_i).sum
  end

  def gross_salary_and_less_paye_count
    test_answers = self.test_answers('t3')
    result_array = []
    Answer::GROSS_SALARY_AND_LESS_PAYE.each do |code|
      test_answers.find{ |answer| result_array << answer.result if (answer.code == code) }
    end
    result = result_array.compact.map(&:to_i).sum
  end

  def net_business_income
    test_answers = self.test_answers('t3')
    p self.answers.find_by_code("t3q13").result
    answer_result = self.answers.find_by_code("t3q13").result
    result = apply_income_tax? ? (answer_result.to_i - answer_result.to_i * Answer::COMPANY_INCOME_TAX) : answer_result.to_i
  end
end
