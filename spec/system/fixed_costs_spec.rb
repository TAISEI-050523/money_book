require 'rails_helper'

RSpec.describe '固定費入力', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @fixed_cost = FactoryBot.create(:fixed_cost)
    @fixed_cost_fixed_cost_category_id = @fixed_cost.fixed_cost_category_id    # 固定費分類
    @fixed_cost_remarks = @fixed_cost.remarks                          # 備考
    @fixed_cost_price = @fixed_cost.price                              # 金額
    # date_fieldに入力するため変換(例：2020-01-01 ➜ 002020-01-01)
    @expense_date = "00#{@fixed_cost.expense_date.year}-#{@fixed_cost.expense_date.mon}-#{@fixed_cost.expense_date.day}" # 出金日
  end
  context '固定費を入力ができるとき' do
    it 'ログインしたユーザーは固定費入力ページで固定費の入力ができる' do
      # ログインする
      sign_in(@user)
      # 固定費入力ページへのリンクがあることを確認する
      expect(page).to have_link('固定費', href: new_fixed_cost_path)
      # 固定費入力ページに移動する
      visit new_fixed_cost_path
      # 入力フォームに情報を入力する
      find('#category-id').find("option[value='#{@fixed_cost_fixed_cost_category_id}']").select_option
      fill_in 'remarks', with: @fixed_cost_remarks
      fill_in 'price', with: @fixed_cost_price
      fill_in 'date', with: @expense_date
      click_on('入 力')
      # 入力後、固定費入力ページに留まることを確認する
      expect(current_path).to eq new_fixed_cost_path
      # 固定費入力ページには先ほど入力した内容が固定費詳細欄に存在することを確認する（固定費分類）
      expect(find('#details')).to have_content(@fixed_cost.fixed_cost_category.name)
      # 固定費入力ページには先ほど入力した内容が固定費詳細欄に存在することを確認する（備考）
      expect(find('#details')).to have_content(@fixed_cost_remarks)
      # 固定費入力ページには先ほど入力した内容が固定費詳細欄に存在することを確認する（金額）
      expect(find('#details')).to have_content(@fixed_cost_price.to_s(:delimited))
      # 固定費入力ページには先ほど入力した内容が固定費詳細欄に存在することを確認する（出金日）
      expect(find('#details')).to have_content(@fixed_cost_expense_date)
    end
  end
  context '固定費を入力ができないとき' do
    it '誤った情報では固定費入力ができずに固定費入力ページへ戻ってくる' do
      # ログインする
      sign_in(@user)
      # 固定費入力ページへのリンクがあることを確認する
      expect(page).to have_link('固定費', href: new_fixed_cost_path)
      # 固定費入力ページに移動する
      visit new_fixed_cost_path
      # 入力フォームに誤った情報を入力する
      find('#category-id').find("option[value='1']").select_option # value='1' ➜ fixed_cost_fixed_cost_category_id=1
      fill_in 'remarks', with: ' '
      fill_in 'price', with: ' '
      fill_in 'expense_date', with: ' '
      click_on('入 力')
      # アラートが表示されて、アラートを消去できることを確認する
      page.accept_alert
      # 入力後、固定費入力ページに留まることを確認する
      expect(current_path).to eq new_fixed_cost_path
    end
  end
end

RSpec.describe '固定費削除', type: :system do
  before do
    @fixed_cost1 = FactoryBot.create(:fixed_cost)       # 固定費１
    @fixed_cost2 = FactoryBot.create(:fixed_cost)       # 固定費２
  end
  context '固定費を削除ができるとき' do
    it 'ログインしたユーザーは自らが入力した固定費詳細の削除ができる' do
      # 固定費1を入力したユーザーでログインする
      sign_in(@fixed_cost1.user)
      # 固定費入力ページへのリンクがあることを確認する
      expect(page).to have_link('固定費', href: new_fixed_cost_path)
      # 固定費入力ページに移動する
      visit new_fixed_cost_path
      # 固定費詳細欄の固定費1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 入力を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: fixed_cost_path(@fixed_cost1)).click
      end.to change { FixedCost.count }.by(-1)
      # 削除後、固定費入力ページに留まることを確認する
      expect(current_path).to eq new_fixed_cost_path
      # 固定費詳細欄には固定費１の内容が存在しないことを確認する（固定費分類の欄）
      expect(find('#details')).to have_no_content(@fixed_cost1.fixed_cost_category.name)
      # 固定費詳細欄には固定費１の内容が存在しないことを確認する（備考の欄）
      expect(find('#details')).to have_no_content(@fixed_cost1.remarks)
      # 固定費詳細欄には固定費１の内容が存在しないことを確認する（金額の欄）
      expect(find('#details')).to have_no_content(@fixed_cost1.price.to_s(:delimited))
      # 固定費詳細欄には固定費１の内容が存在しないことを確認する（出金日の欄）
      expect(find('#details')).to have_no_content(@fixed_cost1.expense_date.strftime('%Y年%m月%d日'))
    end
  end
  context '固定費削除ができないとき' do
    it 'ログインしたユーザーは自分以外が入力した固定費の削除ができない' do
      # 固定費1を入力したユーザーでログインする
      sign_in(@fixed_cost1.user)
      # 固定費入力ページへのリンクがあることを確認する
      expect(page).to have_link('固定費', href: new_fixed_cost_path)
      # 固定費入力ページに移動する
      visit new_fixed_cost_path
      # 固定費詳細欄に固定費1の「削除」ボタンがあることを確認する
      expect(find('#details')).to have_link '削除', href: fixed_cost_path(@fixed_cost1)
      # 固定費詳細欄に固定費2の「削除」ボタンがないことを確認する
      expect(find('#details')).to have_no_link '削除', href: fixed_cost_path(@fixed_cost2)
    end
  end
end

RSpec.describe '固定費検索', type: :system do
  before do
    @fixed_cost = FactoryBot.create(:fixed_cost)
    @fixed_cost_fixed_cost_category_id = @fixed_cost.fixed_cost_category_id # 固定費分類
    @expense_date = @fixed_cost.expense_date # 出金日
    @fixed_cost_year = @expense_date.year.to_s                      # 出金日の年
    @fixed_cost_month = @expense_date.mon.to_s                      # 出金日の月
  end
  context '固定費検索ができるとき' do
    it 'ログインしたユーザーは固定費入力ページで固定費の検索ができる' do
      # ログインする
      sign_in(@fixed_cost.user)
      # 固定費入力ページへのリンクがあることを確認する
      expect(page).to have_link('固定費', href: new_fixed_cost_path)
      # 固定費入力ページに移動する
      visit new_fixed_cost_path
      # 検索フォームに情報を入力して検索ボタンを押す
      find('#fixed_cost_category_id').find("option[value='#{@fixed_cost_fixed_cost_category_id}']").select_option
      find('#year').find("option[value='#{@fixed_cost_year}']").select_option
      find('#month').find("option[value='#{@fixed_cost_month}']").select_option
      click_on('検索')
      # 検索結果ページに遷移することを確認する
      expect(current_path).to eq search_fixed_costs_path
      # 固定費検索結果ページには先ほど検索した内容が存在することを確認する（固定費分類）
      expect(find('#details')).to have_content(@fixed_cost.fixed_cost_category.name)
      # 固定費検索結果ページには先ほど検索した内容が存在することを確認する（出金日）
      expect(find('#details')).to have_content(@expense_date.strftime('%Y年%m月%d日'))
      # 固定費検索結果ページには先ほど検索した内容に付随した内容が存在することを確認する（備考）
      expect(find('#details')).to have_content(@fixed_cost.remarks)
      # 固定費検索結果ページには先ほど検索した内容に付随した内容が存在することを確認する（金額）
      expect(find('#details')).to have_content(@fixed_cost.price.to_s(:delimited))
    end
  end
end
