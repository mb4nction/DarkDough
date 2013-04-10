class TestsController < ApplicationController
	
	def index
		ret1 = send_sms("234-8034070931","KpLi3")
		ret2 = send_sms("234-8067061528","JetKE")
		render :text=>(ret1.inspect.to_s+ret2.inspect.to_s) and return
	end
	
	def create
		if params[:test][:answer_sort]=="HARDFACTS" 
			answer_sort = params[:test][:answer_sort]
			question_ids = params[:question_id]
			answers = params[:answer]
			
			k = 0
			s = ""
			question_ids.each do |question_id|
				answer = answers[k]
				@test = current_user.tests.where("question_id='#{question_id}'")
				r = {:question_id=>question_id, :answer=>answer, :answer_sort=>answer_sort}
				if @test.size==0
					@test = current_user.tests.build r
					@test.save
				else
					@test = @test.first
					@test.update_attributes( r );
				end
				k = k + 1
			end
			render :json=>{status:true}
    end
    if params[:test][:answer_sort]=="CASHFLOW"
			answer_sort = params[:test][:answer_sort]
			question_ids = params[:question_id]
			answers = params[:answer]
			
			k = 0
			s = ""
			answers.each do |key, value|
				@test = current_user.tests.where("question_id='#{key}'")
				r = {:question_id=>key, :answer=>value, :answer_sort=>answer_sort}
				if @test.size==0
					@test = current_user.tests.build r
					@test.save
				else
					@test = @test.first
					@test.update_attributes( r );
				end
				k = k + 1
			end
      if params.has_key?("answer_radio")
        answers = params[:answer_radio]
        answers.each do | key, value |
          @test = current_user.tests.where("question_id='#{key}'")
          r = {:question_id=>key, :answer=>value, :answer_sort=>answer_sort}
          if @test.size==0
            @test = current_user.tests.build r
            @test.save
          else
            @test = @test.first
            @test.update_attributes( r );
          end
        end
      end
			render :json=>{status:true}
		else
			@test = current_user.tests.where("question_id=#{params[:test][:question_id]}")
			if @test.size==0
				@test = current_user.tests.build params[:test]
				@test.save
			else
				@test = @test.first
				@test.update_attributes(params[:test]);
			end
			render :json=>{status:true}
		end
	end
	def update
	end
	def destroy
	end
end
