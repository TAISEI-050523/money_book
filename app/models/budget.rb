class Budget < ApplicationRecord
  belongs_to :user

  with_options presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_001, message: 'は半角数字で 1円 以上  1,000,000 円 以内で入力してください' } do
    validates :house
    validates :communications
    validates :electricity
    validates :gas
    validates :water
    validates :education
    validates :premium
    validates :lawn
    validates :fixed_etcetera
    validates :food
    validates :commodity
    validates :transportation
    validates :hobby
    validates :clothes
    validates :health
    validates :culture
    validates :book
    validates :cafe
    validates :social
    validates :special
    validates :variable_etcetera
  end
end
