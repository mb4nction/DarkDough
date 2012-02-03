module AcumenTestHelper
  def worry_test_resulting
    res = first_test_count[:worry]
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
    res = first_test_count[:discipline]
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
    res = first_test_count[:thrill_seeking]
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
  
end