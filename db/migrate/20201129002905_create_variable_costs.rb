class CreateVariableCosts < ActiveRecord::Migration[6.0]
  def change
    create_table :variable_costs do |t|
      t.integer :variable_cost_category_id, null: false
      t.text :remarks
      t.integer :price, null: false
      t.date :expense_date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
