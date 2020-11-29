class FixedCost < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :fixed_cost_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true }
    validates :date_entered
  end

  #収入区分の選択が「--」の時は保存できないようにする
  validates :fixed_cost_category_id, numericality: { other_than: 1, message: 'Select.'} 
end
