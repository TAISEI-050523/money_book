require 'rails_helper'

RSpec.describe Budget, type: :model do
  before do
    @budget = FactoryBot.build(:budget)
  end

  context '予算登録・編集がうまくいくとき' do
    it 'name, price, purchase_dateが存在すれば登録できること' do
      expect(@budget).to be_valid
    end
  end

  context '予算登録・編集がうまくいかないとき' do
    #### カラムが空では登録できない ####
    it 'house(住居費)が空では登録できないこと' do
      @budget.house = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'communications(通信費)が空では登録できないこと' do
      @budget.communications = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'electricity(電気代)が空では登録できないこと' do
      @budget.electricity = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'gas(ガス代)が空では登録できないこと' do
      @budget.gas = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'water(水道代)が空では登録できないこと' do
      @budget.water = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'education(教育費)が空では登録できないこと' do
      @budget.education = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'premium(保険代)が空では登録できないこと' do
      @budget.premium = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'lawn(ローン)が空では登録できないこと' do
      @budget.lawn = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'fixed_etcetera(固定費その他)が空では登録できないこと' do
      @budget.fixed_etcetera = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'food(食費)が空では登録できないこと' do
      @budget.food = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'commodity(日用品)が空では登録できないこと' do
      @budget.commodity = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'transportation(交通費)が空では登録できないこと' do
      @budget.transportation = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'hobby(趣味・娯楽)が空では登録できないこと' do
      @budget.hobby = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'clothes(衣服・美容)が空では登録できないこと' do
      @budget.clothes = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'health(健康・医療)が空では登録できないこと' do
      @budget.health = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'culture(教養・教育)が空では登録できないこと' do
      @budget.culture = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'book(書籍)が空では登録できないこと' do
      @budget.book = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'cafe(カフェ)が空では登録できないこと' do
      @budget.cafe = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'social(交際費)が空では登録できないこと' do
      @budget.social = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'special(特別費)が空では登録できないこと' do
      @budget.special = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'variable_etcetera(変動費その他)が空では登録できないこと' do
      @budget.variable_etcetera = nil
      @budget.valid?
      expect(@budget).not_to be_valid
    end

    #### カラムに半角英字が含まれる ####
    it 'house(住居費)が半角英字では登録できないこと' do
      @budget.house = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'communications(通信費)が半角英字では登録できないこと' do
      @budget.communications = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'electricity(電気代)が半角英字では登録できないこと' do
      @budget.electricity = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'gas(ガス代)が半角英字では登録できないこと' do
      @budget.gas = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'water(水道代)が半角英字では登録できないこと' do
      @budget.water = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'education(教育費)が半角英字では登録できないこと' do
      @budget.education = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'premium(保険代)が半角英字では登録できないこと' do
      @budget.premium = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'lawn(ローン)が半角英字では登録できないこと' do
      @budget.lawn = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'fixed_etcetera(固定費その他)が半角英字では登録できないこと' do
      @budget.fixed_etcetera = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'food(食費)が半角英字では登録できないこと' do
      @budget.food = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'commodity(日用品)が半角英字では登録できないこと' do
      @budget.commodity = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'transportation(交通費)が半角英字では登録できないこと' do
      @budget.transportation = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'hobby(趣味・娯楽)が半角英字では登録できないこと' do
      @budget.hobby = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'clothes(衣服・美容)が半角英字では登録できないこと' do
      @budget.clothes = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'health(健康・医療)が半角英字では登録できないこと' do
      @budget.health = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'culture(教養・教育)が半角英字では登録できないこと' do
      @budget.culture = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'book(書籍)が半角英字では登録できないこと' do
      @budget.book = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'cafe(カフェ)が半角英字では登録できないこと' do
      @budget.cafe = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'social(交際費)が半角英字では登録できないこと' do
      @budget.social = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'special(特別費)が半角英字では登録できないこと' do
      @budget.special = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'variable_etcetera(変動費その他)が半角英字では登録できないこと' do
      @budget.variable_etcetera = 'abcdef'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    ####  全角数字が含まれる ####
    it 'house(住居費)が全角数字では登録できないこと' do
      @budget.house = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'communications(通信費)が全角数字では登録できないこと' do
      @budget.communications = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'electricity(電気代)が全角数字では登録できないこと' do
      @budget.electricity = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'gas(ガス代)が全角数字では登録できないこと' do
      @budget.gas = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'water(水道代)が全角数字では登録できないこと' do
      @budget.water = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'education(教育費)が全角数字では登録できないこと' do
      @budget.education = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'premium(保険代)が全角数字では登録できないこと' do
      @budget.premium = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'lawn(ローン)が全角数字では登録できないこと' do
      @budget.lawn = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'fixed_etcetera(固定費その他)が全角数字では登録できないこと' do
      @budget.fixed_etcetera = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'food(食費)が全角数字では登録できないこと' do
      @budget.food = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'commodity(日用品)が全角数字では登録できないこと' do
      @budget.commodity = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'transportation(交通費)が全角数字では登録できないこと' do
      @budget.transportation = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'hobby(趣味・娯楽)が全角数字では登録できないこと' do
      @budget.hobby = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'clothes(衣服・美容)が全角数字では登録できないこと' do
      @budget.clothes = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'health(健康・医療)が全角数字では登録できないこと' do
      @budget.health = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'culture(教養・教育)が全角数字では登録できないこと' do
      @budget.culture = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'book(書籍)が全角数字では登録できないこと' do
      @budget.book = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'cafe(カフェ)が全角数字では登録できないこと' do
      @budget.cafe = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'social(交際費)が全角数字では登録できないこと' do
      @budget.social = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'special(特別費)が全角数字では登録できないこと' do
      @budget.special = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'variable_etcetera(変動費その他)が全角数字では登録できないこと' do
      @budget.variable_etcetera = '１２３４５６'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    ##### コンマ(,)が含まれる ####
    it 'house(住居費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.house = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'communications(通信費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.communications = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'electricity(電気代)にコンマ(,)が含まれていると登録できないこと' do
      @budget.electricity = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'gas(ガス代)にコンマ(,)が含まれていると登録できないこと' do
      @budget.gas = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'water(水道代)にコンマ(,)が含まれていると登録できないこと' do
      @budget.water = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'education(教育費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.education = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'premium(保険代)にコンマ(,)が含まれていると登録できないこと' do
      @budget.premium = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'lawn(ローン)にコンマ(,)が含まれていると登録できないこと' do
      @budget.lawn = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'fixed_etcetera(固定費その他)にコンマ(,)が含まれていると登録できないこと' do
      @budget.fixed_etcetera = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'food(食費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.food = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'commodity(日用品)にコンマ(,)が含まれていると登録できないこと' do
      @budget.commodity = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'transportation(交通費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.transportation = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'hobby(趣味・娯楽)にコンマ(,)が含まれていると登録できないこと' do
      @budget.hobby = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'clothes(衣服・美容)にコンマ(,)が含まれていると登録できないこと' do
      @budget.clothes = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'health(健康・医療)にコンマ(,)が含まれていると登録できないこと' do
      @budget.health = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'culture(教養・教育)にコンマ(,)が含まれていると登録できないこと' do
      @budget.culture = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'book(書籍)にコンマ(,)が含まれていると登録できないこと' do
      @budget.book = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'cafe(カフェ)にコンマ(,)が含まれていると登録できないこと' do
      @budget.cafe = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'social(交際費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.social = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'special(特別費)にコンマ(,)が含まれていると登録できないこと' do
      @budget.special = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    it 'variable_etcetera(変動費その他)にコンマ(,)が含まれていると登録できないこと' do
      @budget.variable_etcetera = '10,000'
      @budget.valid?
      expect(@budget).not_to be_valid
    end
    #### user_id ####
    it 'userが紐付いていないと保存できないこと' do
      @budget.user = nil
      @budget.valid?
      expect(@budget.errors.full_messages).to include('User must exist')
    end
  end
end
