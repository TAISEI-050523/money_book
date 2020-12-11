class PurchasePlan < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :purchase_date
  end
end
