class PurchasePlan < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }
    validates :purchase_date
  end
end
