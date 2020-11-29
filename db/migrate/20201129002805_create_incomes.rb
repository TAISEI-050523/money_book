class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.integer :income_category_id, null: false
      t.text :remarks
      t.integer :price, null: false
      t.date :income_date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
