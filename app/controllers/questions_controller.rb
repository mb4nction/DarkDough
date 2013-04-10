class QuestionsController < ApplicationController
	def index
	end
	
	def new

	end
	
	def touchfeely
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::HARDFACTS.count
	
		@questions = Question.all(:conditions=>"qgroup=1")
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"t_#{t.question_id}"] = t
		end
	end
	
	def hardfacts
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::HARDFACTS.count
	
		@questions = Question::HARDFACTS
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"#{t.question_id}"] = t
		end
	end
	
	def cashflow
		@touchfeely_count = Question.all(:conditions=>"qgroup=1").count
		@hardfacts_count = Question::CASHFLOW.count
	
		@questions = Question::CASHFLOW
		@test = Test.new

		@current_tests = current_user.tests
		@tests = {}
		@current_tests.each do |t|
			@tests[:"#{t.question_id}"] = t
		end
	end
	
	def testresult
		tests = current_user.tests
		res = ""
		mwsed = {
			:M => 0,
			:S => 0,
			:W => 0,
			:E => 0,
			:D => 0
		}
		assets = 0
		liabilities = 0
		personal_income = 0
		business_income = 0
		cash_surplus = 0
		res = ""
		tests.each do |t|
			case t.answer_sort
				when "radio"
					case t.answer
						when "_SD", "_MD" , "_AD" , "_MA" , "_SA", "_PRF1", "_PRF2", "_yes", "_no",
								"_extremely", "_very", "_moderately", "_mildly", "_notatall"
							#res += "\n" + t.inspect + " => " + t.question.trait + " => " + t.question.answer_type + " => " +
								Question::ANSWER_TYPE[:"#{t.question.answer_type}"][:answers][:"#{t.answer}"][:score].to_s
							t.question.trait.scan(/\w+|\n/) do |w|
								mwsed[:"#{w}"] += Question::ANSWER_TYPE[:"#{t.question.answer_type}"][:answers][:"#{t.answer}"][:score]
							end
					end
				when "radio_with_multivalue"
					k = 0
					t.answer.scan(/\w+|\n/) do |w|
						div = 3**k
						k1 = 0
						t.question.trait.scan(/\w+|\n/) do |w1|
							m = Question::ANSWER_TYPE[:"#{t.question.answer_type}"][:answers][:"#{w}"][:score][k1]
							mwsed[:"#{w1}"] += m.to_f/div
							#res += ", #{m}/#{div} = " + (m.to_f/div).to_s
							k1 = k1 + 1
						end
						k = k + 1
					end
				when "table"
					#res += "\n" + t.inspect + " => " + t.question.trait + " => " + t.question.answer_type
					t.question.trait.scan(/\w+|\n/) do |w|
						t.answer.lines.each do |line|
							k,v = line.chomp.split(/\=\>/)
							score = Question::ANSWER_TYPE[:"#{t.question.answer_type}"][:scores][:"#{v}"][:score]
							mwsed[:"#{w}"] += score
						end
					end
				when "check"
					#res += "\n" + t.inspect + " => " + t.question.trait + " => " + t.question.answer_type
					#res += ">>>" + t.answer.split(/\,/).size.to_s
					score = case t.answer.split(/\,/).size
						when 0
							-2
						when 1
							-1
						when 2
							1
						else
							2
					end
					#res += ">>>" + score.to_s
					t.question.trait.scan(/\w+|\n/) do |w|
						mwsed[:"#{w}"] += score
					end
				when "multiline_text"
					#res += "\n" + t.inspect + " => " + t.question.trait + " => " + t.question.answer_type
					#res += ">>>" + t.answer.lines.count.to_s
					score = case t.answer.lines.count
						when 0
							-2
						when 1
							-1
						when 2
							1
						else
							2
					end
					t.question.trait.scan(/\w+|\n/) do |w|
						mwsed[:"#{w}"] += score
					end
			end
			
			if t.answer_sort == Question::HARDFACTS[:_name]
				#res += "<br>"+t.answer_sort+":"+Question::HARDFACTS[:_name]
				idx = t.question_id[Question::HARDFACTS[:_prefix].length+1, 1000]
				if Question::HARDFACTS[:_assets][:"#{idx}"]!=nil
					assets += t.answer.gsub(/,/,"").to_f
				end
				if Question::HARDFACTS[:_liabilities][:"#{idx}"]!=nil
					liabilities += t.answer.gsub(/,/,"").to_f
				end
			end
			
      
			
			if t.answer_sort == Question::CASHFLOW[:_name]
				#res += "<br>"+t.answer_sort+":"+Question::CASHFLOW[:_name]
				idx = t.question_id[Question::CASHFLOW[:_prefix].length+1, 1000]
				if Question::PERSONAL_INCOME[:"#{idx}"]!=nil
					if Question::PERSONAL_INCOME[:"#{idx}"][:sum_mode]=='+'
						personal_income += t.answer.gsub(/,/,"").to_f
					else
						personal_income -= t.answer.gsub(/,/,"").to_f
					end
				end
				
				if Question::BUSINESS_INCOME[:"#{idx}"]!=nil
					business_income += t.answer.gsub(/,/,"").to_f
				end
	
				if Question::CASH_SURPLUS[:"#{idx}"]!=nil
					if Question::CASH_SURPLUS[:"#{idx}"][:sum_mode]=='+'
						cash_surplus += t.answer.gsub(/,/,"").to_f
					else
						cash_surplus -= t.answer.gsub(/,/,"").to_f
					end
				end
			end
		end
		
		networth = assets - liabilities
		current_ratio = ((assets.to_f / liabilities)*100).round(2)
		debt_ratio = ((liabilities.to_f / networth)*100).round(2)

		mwsed.each do |k, v|
			mwsed[k] = v.round(0)
		end
		
		mm = {}; mm[:range] = [-18..-15, -14..-6, -5..7, 8..13, 14..18]
		ww = {}; ww[:range] = [-44..-32, -31..-13, -12..12, 13..31, 32..44]
		ss = {}; ss[:range] = [-30..-23, -22..-11, -10..10, 11..21, 22..30]
		ee = {}; ee[:range] = [-22..-16, -15..-7, -6..8, 9..14, 15..22]
		dd = {}; dd[:range] = [-18..-15, -14..-6, -5..7, 8..13, 14..18]
		
		mm[:class] = case mwsed[:M]
			when mm[:range][0] then 0
			when mm[:range][1] then 1
			when mm[:range][2] then 2
			when mm[:range][3] then 3
			when mm[:range][4] then 4
		end
		mm[:percent] = percent_of_range(mwsed[:M], mm[:range].first.first..mm[:range].last.last )
		
		ww[:class] = case mwsed[:W]
			when ww[:range][0] then 0
			when ww[:range][1] then 1
			when ww[:range][2] then 2
			when ww[:range][3] then 3
			when ww[:range][4] then 4
		end
		ww[:percent] = percent_of_range(mwsed[:W], ww[:range].first.first..ww[:range].last.last )
		
		ss[:class] = case mwsed[:S]
			when ss[:range][0] then 0
			when ss[:range][1] then 1
			when ss[:range][2] then 2
			when ss[:range][3] then 3
			when ss[:range][4] then 4
		end
		ss[:percent] = percent_of_range(mwsed[:S], ss[:range].first.first..ss[:range].last.last )
		
		ee[:class] = case mwsed[:E]
			when ee[:range][0] then 0
			when ee[:range][1] then 1
			when ee[:range][2] then 2
			when ee[:range][3] then 3
			when ee[:range][4] then 4
		end
		ee[:percent] = percent_of_range(mwsed[:E], ee[:range].first.first..ee[:range].last.last )

		dd[:class] = case mwsed[:D]
			when dd[:range][0] then 0
			when dd[:range][1] then 1
			when dd[:range][2] then 2
			when dd[:range][3] then 3
			when dd[:range][4] then 4
		end
		dd[:percent] = percent_of_range(mwsed[:D], dd[:range].first.first..dd[:range].last.last )

		mm[:type] = "Livewire"
		ww[:type] = "Nihilist"
		ss[:type] = "Sovereign"
		ee[:type] = "Swashbuckler"
		dd[:type] = "Adherent"
		
		dominant = mm
		dominant = ww if dominant[:class] < ww[:class]
		dominant = ss if dominant[:class] < ss[:class]
		dominant = ee if dominant[:class] < ee[:class]
		dominant = dd if dominant[:class] < dd[:class]
		
	
		

		user_age = (current_user.age=="undef"?42:current_user.age)
		@personal_info = {}
		@personal_info[:name] = "#{current_user.first_name} #{current_user.last_name}"
		@personal_info[:location] = current_user.country
		@personal_info[:taken] = tests.last.created_at.strftime("%d, %B, %Y")
		@personal_info[:next] = (tests.last.created_at+20.day).strftime("%d, %B, %Y")
		@personal_info[:next_comment] = "You can be taken at next test in 20 days."
		@personal_info[:picture] = "/assets/person.png"
		@personal_info[:first_job] = tests.where(:question_id=>'_c__how_old_were_you').first.answer
		@personal_info[:age] = user_age
		@personal_info[:retirement_age] = tests.where(:question_id=>'_c__at_what_age').first.answer
		@personal_info[:life_expectancy] = 90 #90 years for men and 95 years for women
		
		@personality = {}
		@personality[:type] = dominant[:type]
		@personality[:saving_rate] = Question::saving_ratio(user_age)
		
		@personality[:ww] = mwsed[:W]
		@personality[:ss] = mwsed[:S]
		@personality[:mm] = mwsed[:M]
		@personality[:ee] = mwsed[:E]
		@personality[:dd] = mwsed[:D]
		
		@mwsed_percent = {
			:mm=>mm[:percent],
			:ww=>ww[:percent],
			:ss=>ss[:percent],
			:ee=>ee[:percent],
			:dd=>dd[:percent]
		}
		
		@personality_1 = {}
		@personality_1[:ww] = {:value=>@personality[:ww], :comment=>"Worry refers to financial anxiety. High scorers experience more financial stress when thinking about their finances. It usually helps to take a long-term view and reduce the frequency of evaluation of your assets (such as stocks) for changes in value. They see the dark cloud in every silver lining and are obsessed with risk management. Taking a passive approach to their investments is usually an effective coping strategy. Low scorers on the other hand may be financially reckless and may exhibit risk-seeking behaviour. <br>YOUR LEVEL OF WORRY IS #{@personality[:ww]}"}
		@personality_1[:ss] = {:value=>@personality[:ss], :comment=>"Self-interested people will be more financially independent. High scorers are more likely to be autonomous decision makers, even to the point of distrusting outside financial advisors' intentions. Additionally, they abhor whatever may feasibly be construed as wastage such as high fees for a service or even charitable giving. Low scorers are more financially open and accommodative towards others. Low scorers may also be more trusting and generous, which makes them ideal targets for inappropriate requests for money from relatives and friends. They may also entertain feelings of guilt over their wealth and may be somewhat indecisive when considering financial plans. <br>YOUR LEVEL OF SELF INTEREST IS #{@personality[:ss]}"}
		@personality_1[:mm] = {:value=>@personality[:mm], :comment=>"Motivation refers to the level of interest in learning about investments, keeping track of economic trends, and managing money. High scorers are likely to have some enthusiasm for managing their own finances. They are also more likely to be self-starters who will perform requested research and take an active interest in managing their money. Low scorers typically require some education. Low scorers will lose interest in managing their finances if it is perceived as dull or tedious. <br>YOUR LEVEL OF MOTIVATION IS #{@personality[:mm]}"}
		@personality_1[:ee] = {:value=>@personality[:ee], :comment=>"Thrill seeking as the name implies refers to people who seek excitement even in their investing and financial planning. Financial thrill seeking is not necessarily always bad as it can motivate people to unearth opportunities. Thrill seeking can be a problem when it leads to imprudence and excessive risk taking. High scorers are more inclined to pick volatile stocks, neglect savings, attach undue importance to tips, exhibit a marked preference for high-risk/high-reward strategies and have unsustainably high expectations. Low scorers are likely to be more sober and deliberate decision makers. <br>YOUR LEVEL OF THRILL SEEKING IS #{@personality[:ee]}"}
		@personality_1[:dd] = {:value=>@personality[:dd], :comment=>"Discipline refers to the ability to organise your finances and prepare for financial contingencies. Discipline is necessary in order to follow a financial plan. High scorers are more likely to stay consistent with a plan. Low scorers may not have prioritised financial planning in the past. Low scorers will be helped if they can learn to closely associate their emotions with their planning. For example, they could train themselves to experience guilt when they make an impulsive purchase that jeopardises their budget. Also by learning how to see opportunity in the organisation of their finances, and working to better manage emotional blocks, their financial planning will become more effortless and even fun. <br>YOUR LEVEL OF DISCIPLINE IS #{@personality[:dd]}"}

		
		@personality_2 = [
			{:name=>"Assets", :value=>assets, :color=>"#00b4bb", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:name=>"Liabilities", :value=>liabilities, :color=>"#8166a9", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:name=>"Networth", :value=>networth,:color=>"#eb1819", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:name=>"Individual income", :value=>personal_income, :color=>"#69a917", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:name=>"Business income", :value=>business_income, :color=>"#f5541f", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:name=>"Cash Surplus/Deficit", :value=>cash_surplus, :color=>"#325cb7", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."}
		]
		
		@personality_3 = [
			{:title=>"Current ratio", :percent=>current_ratio, :date=>"23/12/2012", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:title=>"Debt ratio", :percent=>debt_ratio, :date=>"24/12/2012", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
			{:title=>"Networth to Income ratio", :percent=>"6.00", :date=>"25/12/2012", :comment=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit."}
		]
		
	end
	
	def percent_of_range(value, range)
		(((value-range.first).to_f / (range.last - range.first))*100).round(0)
	end
end
