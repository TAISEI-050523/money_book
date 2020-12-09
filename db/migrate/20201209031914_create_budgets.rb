class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.integer :house 
      t.integer :communications 
      t.integer :electricity 
      t.integer :gas 
      t.integer :water 
      t.integer :education 
      t.integer :premium 
      t.integer :lawn 
      t.integer :fixed_etcetera 
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
      t.integer :variable_etcetera
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
