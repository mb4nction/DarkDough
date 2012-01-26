class CreateAcumenTests < ActiveRecord::Migration
  def change
    create_table :acumen_tests do |t|
      t.string :code
      t.string :result

      t.references :user

      t.timestamps
    end
  end
end
