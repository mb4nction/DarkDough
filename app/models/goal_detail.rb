class GoalDetail < ActiveRecord::Base
	belongs_to :goal
	attr_accessible :goal_id, :desc, :checked
	validates :desc, :presence=>true
end
