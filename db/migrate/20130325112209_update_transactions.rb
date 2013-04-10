class UpdateTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :debit, :decimal, :precision => 10, :scale => 2
    add_column :transactions, :credit, :decimal, :precision => 10, :scale => 2
    add_column :transactions, :value_date, :Date
    add_column :transactions, :transaction_date, :Date
    add_column :transactions, :status, :integer
  end
end
