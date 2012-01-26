class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :question
      t.string :answer
      t.integer :answer_number

      t.references :acumen_test, :null => false

      t.timestamps
    end
  end
end
