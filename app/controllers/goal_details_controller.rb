class GoalDetailsController < ApplicationController
  def index
		goal_details = GoalDetail.all
		render :json=>{:status=>true, :result=>goal_details } and return
  end
	
	def show
		goal_id = params[:id]
		goal = Goal.find(goal_id)
		goal_details = goal.goal_details
		render :json=>{:status=>true, :result=>goal_details } and return
	end

  def create
		goal_detail = GoalDetail.new(params[:goal_detail])
		if goal_detail.save
			render :json=>{:status=>true} and return
		else
			render :json=>{:status=>false} and return
		end
  end

  def update
		goal_detail = GoalDetail.find(params[:id])
		unless goal_detail == nil
			if goal_detail.update_attributes(params[:goal_detail])
				render :json=>{:status=>true} and return
			else
				render :json=>{:status=>false} and return
			end
		else
			render :json=>{:status=>false} and return
		end
  end

  def destroy
		GoalDetail.find(params[:id]).delete
		render :json=>{:status=>true} and return
  end

end
