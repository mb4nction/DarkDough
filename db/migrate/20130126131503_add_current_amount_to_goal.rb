class AddCurrentAmountToGoal < ActiveRecord::Migration
  def change
		add_column :goals, :current_amount, :float
  end
end
