class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :category
      t.decimal :amount
      t.string :period

      t.references :user

      t.timestamps
    end
  end
end
