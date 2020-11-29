class CreateFixedCosts < ActiveRecord::Migration[6.0]
  def change
    create_table :fixed_costs do |t|
      t.string :fixed_cost_category_id, null: false
      t.string :remarks
      t.integer :price, null: false
      t.date :expense_date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
