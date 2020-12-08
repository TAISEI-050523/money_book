class CreateFixedBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :fixed_budgets do |t|
      t.integer :house
      t.integer :communications
      t.integer :electricity
      t.integer :gas
      t.integer :water
      t.integer :education
      t.integer :premium
      t.integer :lawn
      t.integer :etcetera
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
