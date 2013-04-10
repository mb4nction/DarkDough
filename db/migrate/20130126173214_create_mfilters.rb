class CreateMfilters < ActiveRecord::Migration
  def change
    create_table :mfilters do |t|
      t.integer :user_id
      t.integer :filter_id
      t.integer :step

      t.timestamps
    end
  end
end
