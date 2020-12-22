require 'rails_helper'

RSpec.describe VariableCost, type: :model do
  before do
    @variable_cost = FactoryBot.build(:variable_cost)
  end

  context '変動費入力がうまくいくとき' do
    it 'variable_cost_category_id, price, expense_dateが存在すれば登録できること' do
      expect(@variable_cost).to be_valid
    end
    it 'remarks(備考)が空でも登録できること' do
      @variable_cost.remarks = nil
      expect(@variable_cost).to be_valid
    end
  end

  context '変動費入力がうまくいかないとき' do
    #### 変動費分類カテゴリー選択 ####
    it 'variable_cost_category_id(変動費分類)が "1" (カテゴリーが"--")では登録できないこと' do
      @variable_cost.variable_cost_category_id = 1
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include('Variable cost category を選択してください')
    end
    #### カラムが空では登録できない ####
    it 'price(金額)が空では登録できないこと' do
      @variable_cost.price = nil
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include("Price can't be blank", 'Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'expense_date(入金日)が空では登録できないこと' do
      @variable_cost.expense_date = nil
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include("Expense date can't be blank")
    end
    #### price ####
    it 'price(金額)が半角英字では登録できないこと' do
      @variable_cost.price = 'abcdef'
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)が全角数字では登録できないこと' do
      @variable_cost.price = '１２３４５６'
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)にコンマ(,)が含まれていると登録できないこと' do
      @variable_cost.price = '10,000'
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    #### user_id ####
    it 'userが紐付いていないと保存できないこと' do
      @variable_cost.user = nil
      @variable_cost.valid?
      expect(@variable_cost.errors.full_messages).to include('User must exist')
    end
  end
end
