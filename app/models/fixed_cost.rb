class FixedCost < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :fixed_cost_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :expense_date
  end

  # 収入区分の選択が「--」の時は保存できないようにする
  validates :fixed_cost_category_id, numericality: { other_than: 1, message: 'を選択してください' }

  def self.fixed_cost_monthly
    one_year_period = (1.years.ago.beginning_of_month)..(Date.today.end_of_month)
    FixedCost.where(expense_date: one_year_period).group('YEAR(expense_date)').group('MONTH(expense_date)').sum(:price)
  end

  def self.fixed_cost_this_month
    this_month = Date.today.beginning_of_month..Date.today.end_of_month
    FixedCost.where(expense_date: this_month).sum(:price)
  end

  def self.search(search1, search2, search3)
    if search1 != '1' && search2.present? && search3.present?
      FixedCost.where(fixed_cost_category_id: search1).where("YEAR(expense_date) = #{search2} AND MONTH(expense_date) = #{search3}")
    elsif search1 != '1' && search2.present?
      FixedCost.where(fixed_cost_category_id: search1).where("YEAR(expense_date) = #{search2}")
    elsif search1 != '1' && search3.present?
      FixedCost.where(fixed_cost_category_id: search1).where("MONTH(expense_date) = #{search3}")
    elsif search1 != '1'
      FixedCost.where(fixed_cost_category_id: search1)
    elsif search2.present? && search3.present?
      FixedCost.where("YEAR(expense_date) = #{search2} AND MONTH(expense_date) = #{search3}")
    elsif search2.present?
      FixedCost.where("YEAR(expense_date) = #{search2}")
    elsif search3.present?
      FixedCost.where("MONTH(expense_date) = #{search3}")
    else
      FixedCost.all
    end
  end
  
end
