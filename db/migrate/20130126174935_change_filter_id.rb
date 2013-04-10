class ChangeFilterId < ActiveRecord::Migration
  def up
		change_column :mfilters, :filter_id, :string
  end

  def down
		change_column :mfilters, :filter_id, :integer
  end
end
