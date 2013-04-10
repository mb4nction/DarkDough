class AddGoalIdToGoalDetails < ActiveRecord::Migration
  def change
		add_column :goal_details, :goal_id, :integer
  end
end
