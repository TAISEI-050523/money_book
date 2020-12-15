class PurchasePlan < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_001, message: 'は半角数字で 1円 以上  1,000,000 円 以内で入力してください' }
    validates :purchase_date
  end
end
