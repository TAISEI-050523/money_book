class FixedCost < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :fixed_cost_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true }
    validates :expense_date
  end

  # 収入区分の選択が「--」の時は保存できないようにする
  validates :fixed_cost_category_id, numericality: { other_than: 1, message: 'Select.' }

  def self.search(search1, search2, search3)
    if search1 != "1" && search2.present? && search3.present?
      FixedCost.where(fixed_cost_category_id: search1 ).where("YEAR(expanse_date) = #{search2} AND MONTH(expanse_date) = #{search3}")
    elsif search1 != "1" && search2.present?
      FixedCost.where(fixed_cost_category_id: search1 ).where("YEAR(expanse_date) = #{search2}")
    elsif search1 != "1" && search3.present?
      FixedCost.where(fixed_cost_category_id: search1 ).where("MONTH(expanse_date) = #{search3}")
    elsif search1 != "1"
      FixedCost.where(fixed_cost_category_id: search1 )
    elsif search2.present? && search3.present?
      FixedCost.where("YEAR(expanse_date) = #{search2} AND MONTH(expanse_date) = #{search3}")
    elsif search2.present?
      FixedCost.where("YEAR(expanse_date) = #{search2}") 
    elsif search3.present?
      FixedCost.where("MONTH(expanse_date) = #{search3}")
    else
      FixedCost.all
    end
  end
  
end
