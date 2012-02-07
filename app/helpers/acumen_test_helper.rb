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
end
