class IncomeCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '給与' },
    { id: 3, name: '一時所得' },
    { id: 4, name: '事業・副業' },
    { id: 5, name: '年金' },
    { id: 6, name: '配当所得' },
    { id: 7, name: '不動産所得' },
    { id: 8, name: 'アルバイト代' },
    { id: 9, name: '不明な入金' },
    { id: 10, name: 'その他収入' }
  ]
  include ActiveHash::Associations
  has_many :incomes
end
