class Income < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :income_category

  with_options presence: true do
    validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :income_date
  end
  # 収入区分の選択が「--」の時は保存できないようにする
  validates :income_category_id, numericality: { other_than: 1, message: 'を選択してください' }

  def self.search(search1, search2, search3)
    if search1 != "1" && search2.present? && search3.present?
      Income.where(income_category_id: search1 ).where("YEAR(income_date) = #{search2} AND MONTH(income_date) = #{search3}")
    elsif search1 != "1" && search2.present?
      Income.where(income_category_id: search1 ).where("YEAR(income_date) = #{search2}")
    elsif search1 != "1" && search3.present?
      Income.where(income_category_id: search1 ).where("MONTH(income_date) = #{search3}")
    elsif search1 != "1"
      Income.where(income_category_id: search1 )
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


