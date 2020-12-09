class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.integer :house, null: false 
      t.integer :communications, null: false
      t.integer :electricity, null: false
      t.integer :gas, null: false
      t.integer :water, null: false
      t.integer :education, null: false
      t.integer :premium, null: false
      t.integer :lawn, null: false
      t.integer :fixed_etcetera, null: false
      t.integer :food, null: false
      t.integer :commodity, null: false
      t.integer :transportation, null: false
      t.integer :hobby, null: false
      t.integer :clothes, null: false
      t.integer :health, null: false
      t.integer :culture, null: false
      t.integer :book, null: false
      t.integer :cafe, null: false
      t.integer :social, null: false
      t.integer :special, null: false
      t.integer :variable_etcetera, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
