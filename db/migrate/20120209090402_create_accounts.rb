class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :status

      t.references :user, :null => false
      t.references :bank

      t.timestamps
    end
  end
end
