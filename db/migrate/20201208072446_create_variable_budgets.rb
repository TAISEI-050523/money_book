class CreateVariableBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :variable_budgets do |t|
      t.integer :food
      t.integer :commodity
      t.integer :transportation
      t.integer :hobby
      t.integer :clothes
      t.integer :health
      t.integer :culture
      t.integer :book
      t.integer :cafe
      t.integer :social
      t.integer :special
      t.integer :etcetera
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
