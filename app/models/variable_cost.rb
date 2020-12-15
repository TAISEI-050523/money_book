class VariableCost < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :variable_cost_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' },
              numericality: { only_integer: true, greater_than: 0, less_than: 10_000_001, message: 'を 1円 以上  1,000,000 円 以内で入力してください' }
    validates :expense_date
  end

  # 収入区分の選択が「--」の時は保存できないようにする
  validates :variable_cost_category_id, numericality: { other_than: 1, message: 'を選択してください' }

  # 過去１年間の月ごとの変動費を算出
  def self.variable_cost_monthly
    one_year_period = (1.years.ago.beginning_of_month)..(Date.today.end_of_month)
    VariableCost.where(expense_date: one_year_period).group('YEAR(expense_date)').group('MONTH(expense_date)').sum(:price)
  end

  # 今月の変動費を算出
  def self.variable_cost_this_month
    this_month = Date.today.beginning_of_month..Date.today.end_of_month
    VariableCost.where(expense_date: this_month).sum(:price)
  end

  # 変動費の検索
  def self.search(search1, search2, search3)
    if search1 != '1' && search2.present? && search3.present?
      VariableCost.where(variable_cost_category_id: search1).where("YEAR(expense_date) = #{search2} AND MONTH(expense_date) = #{search3}")
    elsif search1 != '1' && search2.present?
      VariableCost.where(variable_cost_category_id: search1).where("YEAR(expense_date) = #{search2}")
    elsif search1 != '1' && search3.present?
      VariableCost.where(variable_cost_category_id: search1).where("MONTH(expense_date) = #{search3}")
    elsif search1 != '1'
      VariableCost.where(variable_cost_category_id: search1)
    elsif search2.present? && search3.present?
      VariableCost.where("YEAR(expense_date) = #{search2} AND MONTH(expense_date) = #{search3}")
    elsif search2.present?
      VariableCost.where("YEAR(expense_date) = #{search2}")
    elsif search3.present?
      VariableCost.where("MONTH(expense_date) = #{search3}")
    else
      VariableCost.all
    end
  end

end
