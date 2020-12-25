require 'rails_helper'

RSpec.describe Income, type: :model do
  before do
    @income = FactoryBot.build(:income)
  end

  context '収入入力がうまくいくとき' do
    it 'income_category_id, price, income_dateが存在すれば登録できること' do
      expect(@income).to be_valid
    end
    it 'remarks(備考)が空でも登録できること' do
      @income.remarks = nil
      expect(@income).to be_valid
    end
  end

  context '収入入力がうまくいかないとき' do
    #### 収入分類カテゴリー選択 ####
    it 'income_category_id(収入分類)が "1" (カテゴリーが"--")では登録できないこと' do
      @income.income_category_id = 1
      @income.valid?
      expect(@income.errors.full_messages).to include('Income category を選択してください')
    end
    #### カラムが空では登録できない ####
    it 'price(金額)が空では登録できないこと' do
      @income.price = nil
      @income.valid?
      expect(@income.errors.full_messages).to include("Price can't be blank", 'Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'income_date(入金日)が空では登録できないこと' do
      @income.income_date = nil
      @income.valid?
      expect(@income.errors.full_messages).to include("Income date can't be blank")
    end
    #### price ####
    it 'price(金額)が半角英字では登録できないこと' do
      @income.price = 'abcdef'
      @income.valid?
      expect(@income.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)が全角数字では登録できないこと' do
      @income.price = '１２３４５６'
      @income.valid?
      expect(@income.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)に1円より小さいと登録できないこと' do
      @income.price = '0'
      @income.valid?
      expect(@income.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    it 'price(金額)に10,000,000円より大きいと登録できないこと' do
      @income.price = '10,000,001'
      @income.valid?
      expect(@income.errors.full_messages).to include('Price は半角数字で 1円 以上  1,000,000 円 以内で入力してください')
    end
    #### user_id ####
    it 'userが紐付いていないと保存できないこと' do
      @income.user = nil
      @income.valid?
      expect(@income.errors.full_messages).to include('User must exist')
    end
  end
end
