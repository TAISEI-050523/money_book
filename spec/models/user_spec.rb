require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      #### カラムが空では登録できない ####
      it 'nicknameが空では登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password は英字と数字の両方を含めて設定してください", "Password confirmation doesn't match Password")
      end
      ##### email #####
      it '重複したemailが存在する場合(一意性がない場合)登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは、@を含まなければ登録できないこと' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      ##### password #####
      it 'passwordが半角英数字混合で5文字以下であれば登録できないこと' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordが6文字以上で半角英字だけであれば登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordが6文字以上で半角数字だけであれば登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordが全角では登録できないこと' do
        @user.password = '１２３ＡＢＣ'
        @user.password_confirmation = '１２３ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英字と数字の両方を含めて設定してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
