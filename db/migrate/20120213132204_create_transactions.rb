class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :category
      t.text :description
      t.decimal :amount
      t.text :note
      t.integer :account_id

      t.references :user, :null => false

      t.timestamps
    end
  end
end
