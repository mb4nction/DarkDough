class CreateGoalDetails < ActiveRecord::Migration
  def change
    create_table :goal_details do |t|
			t.string :desc
			t.boolean :checked
      t.timestamps
    end
  end
end
