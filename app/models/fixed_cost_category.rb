class FixedCostCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '住居費' },
    { id: 3, name: '通信費' },
    { id: 4, name: '水道光熱費' },
    { id: 5, name: '教育費' },
    { id: 6, name: '保険料' },
    { id: 7, name: 'ローン' },
    { id: 8, name: 'その他' },
  ]
  include ActiveHash::Associations
  has_many :fixed_costs
end
