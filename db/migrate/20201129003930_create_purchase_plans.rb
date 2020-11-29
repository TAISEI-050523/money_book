class CreatePurchasePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_plans do |t|
      t.integer :category_id, null: false
      t.text :remarks
      t.integer :price, null: false
      t.date :purchase_date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
