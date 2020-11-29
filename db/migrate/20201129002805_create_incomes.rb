class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.string :category_id, null: false
      t.string :remarks
      t.integer :price, null: false
      t.date :date_entered, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
