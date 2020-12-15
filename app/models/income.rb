class Income < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :income_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 10_000_001, message: 'は半角数字で 1円 以上  1,000,000 円 以内で入力してください' }
    validates :income_date
  end
  # 収入区分の選択が「--」の時は保存できないようにする
  validates :income_category_id, numericality: { other_than: 1, message: 'を選択してください' }

  def self.income_monthly
    one_year_period = (1.years.ago.beginning_of_month)..(Date.today.end_of_month)
    Income.where(income_date: one_year_period).group('YEAR(income_date)').group('MONTH(income_date)').sum(:price)  
  end
  
  def self.income_this_month
    this_month = Date.today.beginning_of_month..Date.today.end_of_month 
    Income.where(income_date: this_month).sum(:price)   
  end

  def self.search(search1, search2, search3)
    if search1 != '1' && search2.present? && search3.present?
      Income.where(income_category_id: search1).where("YEAR(income_date) = #{search2} AND MONTH(income_date) = #{search3}")
    elsif search1 != '1' && search2.present?
      Income.where(income_category_id: search1).where("YEAR(income_date) = #{search2}")
    elsif search1 != '1' && search3.present?
      Income.where(income_category_id: search1).where("MONTH(income_date) = #{search3}")
    elsif search1 != '1'
      Income.where(income_category_id: search1)
    elsif search2.present? && search3.present?
      Income.where("YEAR(income_date) = #{search2} AND MONTH(income_date) = #{search3}")
    elsif search2.present?
      Income.where("YEAR(income_date) = #{search2}")
    elsif search3.present?
      Income.where("MONTH(income_date) = #{search3}")
    else
      Income.all
    end
  end
end
