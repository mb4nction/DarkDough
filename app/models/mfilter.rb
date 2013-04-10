class Mfilter < ActiveRecord::Base
	belongs_to :users
	FILTERS = {
		:_step_1 => {:max=>1, :step=>1, :bg_img=>"icon-goal-bg-1.png"},
		:_step_2 => {:max=>2, :step=>2, :bg_img=>"icon-goal-bg-22.png"},
		:_step_3 => {:max=>3, :step=>3, :bg_img=>"icon-goal-bg-3.png"},
		:_step_4 => {:max=>4, :step=>4, :bg_img=>"icon-goal-bg-4.png"},
		:_step_5 => {:max=>5, :step=>5, :bg_img=>"icon-goal-bg-5.png"}
	}
	
	attr_accessible :user_id, :filter_id, :step
end
