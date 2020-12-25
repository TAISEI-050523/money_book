require 'rails_helper'

RSpec.describe '変動費入力', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @variable_cost = FactoryBot.create(:variable_cost)
    @variable_cost_variable_cost_category_id = @variable_cost.variable_cost_category_id    # 変動費分類
    @variable_cost_remarks = @variable_cost.remarks                          # 備考
    @variable_cost_price = @variable_cost.price                              # 金額
    # date_fieldに入力するため変換(例：2020-01-01 ➜ 002020-01-01)
    @expense_date = "00#{@variable_cost.expense_date.year}-#{@variable_cost.expense_date.mon}-#{@variable_cost.expense_date.day}" # 出金日
  end
  context '変動費を入力ができるとき' do
    it 'ログインしたユーザーは変動費入力ページで変動費の入力ができる' do
      # ログインする
      sign_in(@user)
      # 変動費入力ページへのリンクがあることを確認する
      expect(page).to have_link('変動費', href: new_variable_cost_path)
      # 変動費入力ページに移動する
      visit new_variable_cost_path
      # 入力フォームに情報を入力する
      find('#category-id').find("option[value='#{@variable_cost_variable_cost_category_id}']").select_option
      fill_in 'remarks', with: @variable_cost_remarks
      fill_in 'price', with: @variable_cost_price
      fill_in 'date', with: @expense_date
      click_on('入 力')
      # 入力後、変動費入力ページに留まることを確認する
      expect(current_path).to eq new_variable_cost_path
      # 変動費入力ページには先ほど入力した内容が変動費詳細欄に存在することを確認する（変動費分類）
      expect(find('#details')).to have_content(@variable_cost.variable_cost_category.name)
      # 変動費入力ページには先ほど入力した内容が変動費詳細欄に存在することを確認する（備考）
      expect(find('#details')).to have_content(@variable_cost_remarks)
      # 変動費入力ページには先ほど入力した内容が変動費詳細欄に存在することを確認する（金額）
      expect(find('#details')).to have_content(@variable_cost_price.to_s(:delimited))
      # 変動費入力ページには先ほど入力した内容が変動費詳細欄に存在することを確認する（出金日）
      expect(find('#details')).to have_content(@variable_cost_expense_date)
    end
  end
  context '変動費を入力ができないとき' do
    it '誤った情報では変動費入力ができずに変動費入力ページへ戻ってくる' do
      # ログインする
      sign_in(@user)
      # 変動費入力ページへのリンクがあることを確認する
      expect(page).to have_link('変動費', href: new_variable_cost_path)
      # 変動費入力ページに移動する
      visit new_variable_cost_path
      # 入力フォームに誤った情報を入力する
      find('#category-id').find("option[value='1']").select_option # value='1' ➜ variable_cost_variable_cost_category_id=1
      fill_in 'remarks', with: ' '
      fill_in 'price', with: ' '
      fill_in 'expense_date', with: ' '
      click_on('入 力')
      # アラートが表示されて、アラートを消去できることを確認する
      page.accept_alert
      # 入力後、変動費入力ページに留まることを確認する
      expect(current_path).to eq new_variable_cost_path
    end
  end
end

RSpec.describe '変動費削除', type: :system do
  before do
    @variable_cost1 = FactoryBot.create(:variable_cost)       # 変動費１
    @variable_cost2 = FactoryBot.create(:variable_cost)       # 変動費２
  end
  context '変動費を削除ができるとき' do
    it 'ログインしたユーザーは自らが入力した変動費詳細の削除ができる' do
      # 変動費1を入力したユーザーでログインする
      sign_in(@variable_cost1.user)
      # 変動費入力ページへのリンクがあることを確認する
      expect(page).to have_link('変動費', href: new_variable_cost_path)
      # 変動費入力ページに移動する
      visit new_variable_cost_path
      # 変動費詳細欄の変動費1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 入力を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: variable_cost_path(@variable_cost1)).click
      end.to change { VariableCost.count }.by(-1)
      # 削除後、変動費入力ページに留まることを確認する
      expect(current_path).to eq new_variable_cost_path
      # 変動費詳細欄には変動費１の内容が存在しないことを確認する（変動費分類の欄）
      expect(find('#details')).to have_no_content(@variable_cost1.variable_cost_category.name)
      # 変動費詳細欄には変動費１の内容が存在しないことを確認する（備考の欄）
      expect(find('#details')).to have_no_content(@variable_cost1.remarks)
      # 変動費詳細欄には変動費１の内容が存在しないことを確認する（金額の欄）
      expect(find('#details')).to have_no_content(@variable_cost1.price.to_s(:delimited))
      # 変動費詳細欄には変動費１の内容が存在しないことを確認する（出金日の欄）
      expect(find('#details')).to have_no_content(@variable_cost1.expense_date.strftime('%Y年%m月%d日'))
    end
  end
  context '変動費削除ができないとき' do
    it 'ログインしたユーザーは自分以外が入力した変動費の削除ができない' do
      # 変動費1を入力したユーザーでログインする
      sign_in(@variable_cost1.user)
      # 変動費入力ページへのリンクがあることを確認する
      expect(page).to have_link('変動費', href: new_variable_cost_path)
      # 変動費入力ページに移動する
      visit new_variable_cost_path
      # 変動費詳細欄に変動費1の「削除」ボタンがあることを確認する
      expect(find('#details')).to have_link '削除', href: variable_cost_path(@variable_cost1)
      # 変動費詳細欄に変動費2の「削除」ボタンがないことを確認する
      expect(find('#details')).to have_no_link '削除', href: variable_cost_path(@variable_cost2)
    end
  end
end

RSpec.describe '変動費検索', type: :system do
  before do
    @variable_cost = FactoryBot.create(:variable_cost)
    @variable_cost_variable_cost_category_id = @variable_cost.variable_cost_category_id # 変動費分類
    @expense_date = @variable_cost.expense_date # 出金日
    @variable_cost_year = @expense_date.year.to_s                      # 出金日の年
    @variable_cost_month = @expense_date.mon.to_s                      # 出金日の月
  end
  context '変動費検索ができるとき' do
    it 'ログインしたユーザーは変動費入力ページで変動費の検索ができる' do
      # ログインする
      sign_in(@variable_cost.user)
      # 変動費入力ページへのリンクがあることを確認する
      expect(page).to have_link('変動費', href: new_variable_cost_path)
      # 変動費入力ページに移動する
      visit new_variable_cost_path
      # 検索フォームに情報を入力して検索ボタンを押す
      find('#variable_cost_category_id').find("option[value='#{@variable_cost_variable_cost_category_id}']").select_option
      find('#year').find("option[value='#{@variable_cost_year}']").select_option
      find('#month').find("option[value='#{@variable_cost_month}']").select_option
      click_on('検索')
      # 検索結果ページに遷移することを確認する
      expect(current_path).to eq search_variable_costs_path
      # 変動費検索結果ページには先ほど検索した内容が存在することを確認する（変動費分類）
      expect(find('#details')).to have_content(@variable_cost.variable_cost_category.name)
      # 変動費検索結果ページには先ほど検索した内容が存在することを確認する（出金日）
      expect(find('#details')).to have_content(@expense_date.strftime('%Y年%m月%d日'))
      # 変動費検索結果ページには先ほど検索した内容に付随した内容が存在することを確認する（備考）
      expect(find('#details')).to have_content(@variable_cost.remarks)
      # 変動費検索結果ページには先ほど検索した内容に付随した内容が存在することを確認する（金額）
      expect(find('#details')).to have_content(@variable_cost.price.to_s(:delimited))
    end
  end
end
