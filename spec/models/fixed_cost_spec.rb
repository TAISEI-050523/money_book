require 'rails_helper'

RSpec.describe FixedCost, type: :model do
  before do
    @fixed_cost = FactoryBot.build(:fixed_cost)
  end

  context '固定費入力がうまくいくとき' do
    it 'fixed_cost_category_id, price, expense_dateが存在すれば登録できること' do
      expect(@fixed_cost).to be_valid
    end
    it 'remarks(備考)が空でも登録できること' do
      @fixed_cost.remarks = nil
      expect(@fixed_cost).to be_valid
    end
  end

  context '固定費入力がうまくいかないとき' do
    #### 固定費分類カテゴリー選択 ####
    it 'fixed_cost_category_id(固定費分類)が "1" (カテゴリーが"--")では登録できないこと' do
      @fixed_cost.fixed_cost_category_id = 1
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include('Fixed cost category を選択してください')
    end
    #### カラムが空では登録できない ####
    it 'price(金額)が空では登録できないこと' do
      @fixed_cost.price = nil
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include("Price can't be blank", 'Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'expense_date(出金日)が空では登録できないこと' do
      @fixed_cost.expense_date = nil
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include("Expense date can't be blank")
    end
    #### price ####
    it 'price(金額)が半角英字では登録できないこと' do
      @fixed_cost.price = 'abcdef'
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)が全角数字では登録できないこと' do
      @fixed_cost.price = '１２３４５６'
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)に1円より小さいと登録できないこと' do
      @fixed_cost.price = '0'
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)に10,000,000円より大きいと登録できないこと' do
      @fixed_cost.price = '10,000,001'
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    #### user_id ####
    it 'userが紐付いていないと保存できないこと' do
      @fixed_cost.user = nil
      @fixed_cost.valid?
      expect(@fixed_cost.errors.full_messages).to include('User must exist')
    end
  end
end
