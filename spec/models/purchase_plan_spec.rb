require 'rails_helper'

RSpec.describe PurchasePlan, type: :model do
  before do
    @purchase_plan = FactoryBot.build(:purchase_plan)
  end

  context '購入予定リスト追加がうまくいくとき' do
    it 'name, price, purchase_dateが存在すれば登録できること' do
      expect(@purchase_plan).to be_valid
    end
    it 'image(商品画像)が空でも登録できること' do
      @purchase_plan.image = nil
      expect(@purchase_plan).to be_valid
    end
    it 'remarks(備考)が空でも登録できること' do
      @purchase_plan.remarks = nil
      expect(@purchase_plan).to be_valid
    end
  end

  context '購入予定リスト追加がうまくいかないとき' do
    #### カラムが空では登録できない ####
    it 'name(商品名)が空では登録できないこと' do
      @purchase_plan.name = nil
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include("Name can't be blank")
    end
    it 'price(値段)が空では登録できないこと' do
      @purchase_plan.price = nil
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include("Price can't be blank")
    end
    it 'purchase_date(購入予定日)が空では登録できないこと' do
      @purchase_plan.purchase_date = nil
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include("Purchase date can't be blank")
    end
    #### price ####
    it 'price(値段)が半角数字以外では登録できないこと' do
      @purchase_plan.price = 'abcdef'
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include("Price は半角数字で入力してください")
    end
    it 'price(値段)が全角数字では登録できないこと' do
      @purchase_plan.price = '１２３４５６'
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include("Price は半角数字で入力してください")
    end
    it 'price(値段)にコンマ(,)が含まれていると登録できないこと' do
      @purchase_plan.price = '10,000'
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include("Price は半角数字で入力してください")
    end
    #### user_id ####
    it 'userが紐付いていないと保存できないこと' do
      @purchase_plan.user = nil
      @purchase_plan.valid?
      expect(@purchase_plan.errors.full_messages).to include('User must exist')
    end
  end

end
