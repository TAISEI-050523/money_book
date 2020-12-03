class FixedCostCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '住居費' },
    { id: 3, name: '通信費' },
    { id: 4, name: '電気代' },
    { id: 5, name: 'ガス代' },
    { id: 6, name: '水道代' },
    { id: 7, name: '教育費' },
    { id: 8, name: '保険料' },
    { id: 9, name: 'ローン' },
    { id: 10, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :fixed_costs
end
