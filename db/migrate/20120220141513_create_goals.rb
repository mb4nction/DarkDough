class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :category
      t.decimal :amount
      t.decimal :current_balance
      t.date :planned_date
      t.decimal :contribution

      t.references :account
      t.references :user

      t.timestamps
    end
  end
end
