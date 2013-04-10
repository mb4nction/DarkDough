class AddApiKeysToBank < ActiveRecord::Migration
  def change
    add_column :banks, :api_key, :string
    add_column :banks, :api_secret, :string
    add_column :banks, :website, :string
    add_column :banks, :approve, :boolean
    add_column :banks, :type, :string
  end
end
