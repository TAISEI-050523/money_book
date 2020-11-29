class VariableCostCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '食費' },
    { id: 3, name: '日用品' },
    { id: 4, name: '交通費' },
    { id: 5, name: '趣味・娯楽' },
    { id: 6, name: '衣服・美容' },
    { id: 7, name: '健康・医療' },
    { id: 8, name: '教養・教育' },
    { id: 9, name: '書籍' },
    { id: 10, name: 'カフェ' },
    { id: 11, name: '交際費' },
    { id: 12, name: '特別費' },
    { id: 13, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :variable_costs
end
