class Income < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :income_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true }
    validates :income_date
  end

  # 収入区分の選択が「--」の時は保存できないようにする
  validates :income_category_id, numericality: { other_than: 1, message: 'Select.' }
end
