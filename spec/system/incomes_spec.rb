require 'rails_helper'

RSpec.describe "収入入力", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @income = FactoryBot.create(:income)
    @income_income_category_id = @income.income_category_id    # 収入分類
    @income_remarks = @income.remarks                          # 備考
    @income_price = @income.price                              # 金額
    @income_date = "00#{@income.income_date.year}-#{@income.income_date.mon}-#{@income.income_date.day}"  # 入金日
  end
  context '収入入力ができるとき' do
    it 'ログインしたユーザーは収入入力ページで収入の入力ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 収入入力ページへのリンクがあることを確認する
      expect(page).to have_link('収 入', href: new_income_path)
      # 収入入力ページに移動する
      visit new_income_path
      # フォームに情報を入力する
      find("#income_income_category_id").find("option[value='#{@income_income_category_id}']").select_option
      fill_in 'income_remarks', with: @income_remarks
      fill_in 'income_price', with: @income_price
      fill_in 'income_income_date', with: @income_date
      # 送信するとIncomeモデルのカウントが1上がることを確認する
      expect{
        click_on ('入 力')
      }.to change { Income.count }.by(1)
      # 入力後、収入入力ページに留まることを確認する
      expect(current_path).to eq new_income_path
      # 収入入力ページには先ほど入力した内容が収入詳細欄に存在することを確認する（収入分類）
      expect(find("#details")).to have_content(@income.income_category.name)
      # 収入入力ページには先ほど入力した内容が収入詳細欄に存在することを確認する（備考）
      expect(find("#details")).to have_content(@income_remarks)
      # 収入入力ページには先ほど入力した内容が収入詳細欄に存在することを確認する（金額）
      expect(find("#details")).to have_content(@income_price.to_s(:delimited))
      # 収入入力ページには先ほど入力した内容が収入詳細欄に存在することを確認する（入金日）
      expect(find("#details")).to have_content(@income_income_date)
    end
    context '収入入力ができないとき'do
      it 'ログインしていないと収入入力ページに遷移できない' do
        # 収入入力ページに遷移する
        visit new_income_path
        # ログインページにリダイレクトされる
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
RSpec.describe '収入削除', type: :system do
  before do
    @income1 = FactoryBot.create(:income)       # 収入１
    @income2 = FactoryBot.create(:income)       # 収入２
  end
  context '収入を削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した収入詳細の削除ができる' do
      # 収入1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @income1.user.email
      fill_in 'password', with: @income1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 収入入力ページへのリンクがあることを確認する
      expect(page).to have_link('収 入', href: new_income_path)
      # 収入入力ページに移動する
      visit new_income_path
      # 収入詳細欄の収入1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除', href: income_path(@income1)).click
      }.to change { Income.count }.by(-1)
      # 削除後、収入入力ページに留まることを確認する
      expect(current_path).to eq new_income_path
      # 収入詳細欄には収入１の内容が存在しないことを確認する（収入分類の欄）
      expect(find("#details")).to have_no_content(@income1.income_category.name)
      # 収入詳細欄には収入１の内容が存在しないことを確認する（備考の欄）
      expect(find("#details")).to have_no_content(@income1.remarks)
      # 収入詳細欄には収入１の内容が存在しないことを確認する（金額の欄）
      expect(find("#details")).to have_no_content(@income1.price.to_s(:delimited))
      # 収入詳細欄には収入１の内容が存在しないことを確認する（入金日の欄）
      expect(find("#details")).to have_no_content(@income1.income_date)
    end
  end
end
