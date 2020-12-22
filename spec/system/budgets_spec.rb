require 'rails_helper'

RSpec.describe '予算登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @budget = FactoryBot.create(:budget)
  end
  context '予算の登録ができるとき' do
    it 'ログインしたユーザーは予算ページで予算の追加ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 予算ページへのリンクがあることを確認する
      expect(page).to have_link('予 算', href: budgets_path)
      # 予算ページに移動する
      visit budgets_path
      # 予算登録ページへのリンクがあることを確認する
      expect(page).to have_link('予算登録', href: new_budget_path)
      # 予算ページに移動する
      visit new_budget_path
      # 入力フォームに情報を入力する
      fill_in 'budget_house', with: @budget.house
      fill_in 'budget_communications', with: @budget.communications
      fill_in 'budget_electricity', with: @budget.electricity
      fill_in 'budget_gas', with: @budget.gas
      fill_in 'budget_water', with: @budget.water
      fill_in 'budget_education', with: @budget.education
      fill_in 'budget_premium', with: @budget.premium
      fill_in 'budget_lawn', with: @budget.lawn
      fill_in 'budget_fixed_etcetera', with: @budget.fixed_etcetera
      fill_in 'budget_food', with: @budget.food
      fill_in 'budget_commodity', with: @budget.commodity
      fill_in 'budget_transportation', with: @budget.transportation
      fill_in 'budget_hobby', with: @budget.hobby
      fill_in 'budget_clothes', with: @budget.clothes
      fill_in 'budget_health', with: @budget.health
      fill_in 'budget_culture', with: @budget.culture
      fill_in 'budget_book', with: @budget.book
      fill_in 'budget_cafe', with: @budget.cafe
      fill_in 'budget_social', with: @budget.social
      fill_in 'budget_special', with: @budget.special
      fill_in 'budget_variable_etcetera', with: @budget.variable_etcetera
      # 送信するとBudgetモデルのカウントが1上がることを確認する
      expect  do
        click_on('保 存')
      end.to change { Budget.count }.by(1)
      # 入力後、予算ページに遷移ことを確認する
      expect(current_path).to eq budgets_path
      # 予算ページには先ほど入力した内容が存在することを確認する（住居費)
      expect(find('#house-category')).to have_content(@budget.house.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（通信費)
      expect(find('#communications-category')).to have_content(@budget.communications.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（電気代)
      expect(find('#electricity-category')).to have_content(@budget.electricity.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（ガス代)
      expect(find('#gas-category')).to have_content(@budget.gas.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（水道代)
      expect(find('#water-category')).to have_content(@budget.water.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（教育費)
      expect(find('#education-category')).to have_content(@budget.education.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（保険料)
      expect(find('#premium-category')).to have_content(@budget.premium.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（ローン)
      expect(find('#lawn-category')).to have_content(@budget.lawn.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（その他)
      expect(find('#fixed-etcetera-category')).to have_content(@budget.fixed_etcetera.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（食費)
      expect(find('#food-category')).to have_content(@budget.food.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（日用品)
      expect(find('#commodity-category')).to have_content(@budget.commodity.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（交通費)
      expect(find('#transportation-category')).to have_content(@budget.transportation.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（趣味・娯楽)
      expect(find('#hobby-category')).to have_content(@budget.hobby.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（衣服・美容)
      expect(find('#clothes-category')).to have_content(@budget.clothes.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（健康・医療)
      expect(find('#health-category')).to have_content(@budget.health.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（教養・教育)
      expect(find('#culture-category')).to have_content(@budget.culture.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（書籍)
      expect(find('#book-category')).to have_content(@budget.book.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（カフェ)
      expect(find('#cafe-category')).to have_content(@budget.cafe.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（交際費)
      expect(find('#social-category')).to have_content(@budget.social.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（特別費)
      expect(find('#special-category')).to have_content(@budget.special.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（その他)
      expect(find('#variable-etcetera-category')).to have_content(@budget.variable_etcetera.to_s(:delimited))
    end
  end
  context '予算の登録ができないとき' do
    it '誤った情報では予算の登録ができずに予算登録ページへ戻ってくる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 予算ページへのリンクがあることを確認する
      expect(page).to have_link('予 算', href: budgets_path)
      # 予算ページに移動する
      visit budgets_path
      # 予算登録ページへのリンクがあることを確認する
      expect(page).to have_link('予算登録', href: new_budget_path)
      # 予算ページに移動する
      visit new_budget_path
      # 入力フォームに誤った情報を入力する
      fill_in 'budget_house', with: ' '
      fill_in 'budget_communications', with: ' '
      fill_in 'budget_electricity', with: ' '
      fill_in 'budget_gas', with: ' '
      fill_in 'budget_water', with: ' '
      fill_in 'budget_education', with: ' '
      fill_in 'budget_premium', with: ' '
      fill_in 'budget_lawn', with: ' '
      fill_in 'budget_fixed_etcetera', with: ' '
      fill_in 'budget_food', with: ' '
      fill_in 'budget_commodity', with: ' '
      fill_in 'budget_transportation', with: ' '
      fill_in 'budget_hobby', with: ' '
      fill_in 'budget_clothes', with: ' '
      fill_in 'budget_health', with: ' '
      fill_in 'budget_culture', with: ' '
      fill_in 'budget_book', with: ' '
      fill_in 'budget_cafe', with: ' '
      fill_in 'budget_social', with: ' '
      fill_in 'budget_special', with: ' '
      fill_in 'budget_variable_etcetera', with: ' '
      # 送信してもBudgetモデルのカウントは上がらないことを確認する
      expect  do
        click_on('保 存')
      end.to change { Budget.count }.by(0)
      # 入力後、予算登録ページに留まることを確認する
      expect(current_path).to eq '/budgets'
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('入力ミス')
    end
  end
end

RSpec.describe '予算編集', type: :system do
  before do
    @budget1 = FactoryBot.create(:budget)                     # 予算1
    @budget2 = FactoryBot.create(:budget)                     # 予算2
  end
  context '予算の編集ができるとき' do
    it 'ログインしたユーザーは予算ページで予算の追加ができる' do
      # 予算1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @budget1.user.email
      fill_in 'password', with: @budget1.user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 予算ページへのリンクがあることを確認する
      expect(page).to have_link('予 算', href: budgets_path)
      # 予算ページに移動する
      visit budgets_path
      # 予算編集ページへのリンクがあることを確認する
      expect(page).to have_link('予算編集', href: edit_budget_path(@budget1))
      # 予算ページに移動する
      visit edit_budget_path(@budget1)
      # 入力フォームに情報を入力する
      fill_in 'budget_house', with: @budget1.house
      fill_in 'budget_communications', with: @budget1.communications
      fill_in 'budget_electricity', with: @budget1.electricity
      fill_in 'budget_gas', with: @budget1.gas
      fill_in 'budget_water', with: @budget1.water
      fill_in 'budget_education', with: @budget1.education
      fill_in 'budget_premium', with: @budget1.premium
      fill_in 'budget_lawn', with: @budget1.lawn
      fill_in 'budget_fixed_etcetera', with: @budget1.fixed_etcetera
      fill_in 'budget_food', with: @budget1.food
      fill_in 'budget_commodity', with: @budget1.commodity
      fill_in 'budget_transportation', with: @budget1.transportation
      fill_in 'budget_hobby', with: @budget1.hobby
      fill_in 'budget_clothes', with: @budget1.clothes
      fill_in 'budget_health', with: @budget1.health
      fill_in 'budget_culture', with: @budget1.culture
      fill_in 'budget_book', with: @budget1.book
      fill_in 'budget_cafe', with: @budget1.cafe
      fill_in 'budget_social', with: @budget1.social
      fill_in 'budget_special', with: @budget1.special
      fill_in 'budget_variable_etcetera', with: @budget1.variable_etcetera
      # 送信すると編集のためBudgetモデルのカウントが上がらないことを確認する
      expect  do
        click_on('保 存')
      end.to change { Budget.count }.by(0)
      # 入力後、予算ページに遷移ことを確認する
      expect(current_path).to eq budgets_path
      # 予算ページには先ほど入力した内容が存在することを確認する（住居費)
      expect(find('#house-category')).to have_content(@budget1.house.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（通信費)
      expect(find('#communications-category')).to have_content(@budget1.communications.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（電気代)
      expect(find('#electricity-category')).to have_content(@budget1.electricity.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（ガス代)
      expect(find('#gas-category')).to have_content(@budget1.gas.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（水道代)
      expect(find('#water-category')).to have_content(@budget1.water.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（教育費)
      expect(find('#education-category')).to have_content(@budget1.education.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（保険料)
      expect(find('#premium-category')).to have_content(@budget1.premium.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（ローン)
      expect(find('#lawn-category')).to have_content(@budget1.lawn.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（その他)
      expect(find('#fixed-etcetera-category')).to have_content(@budget1.fixed_etcetera.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（食費)
      expect(find('#food-category')).to have_content(@budget1.food.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（日用品)
      expect(find('#commodity-category')).to have_content(@budget1.commodity.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（交通費)
      expect(find('#transportation-category')).to have_content(@budget1.transportation.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（趣味・娯楽)
      expect(find('#hobby-category')).to have_content(@budget1.hobby.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（衣服・美容)
      expect(find('#clothes-category')).to have_content(@budget1.clothes.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（健康・医療)
      expect(find('#health-category')).to have_content(@budget1.health.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（教養・教育)
      expect(find('#culture-category')).to have_content(@budget1.culture.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（書籍)
      expect(find('#book-category')).to have_content(@budget1.book.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（カフェ)
      expect(find('#cafe-category')).to have_content(@budget1.cafe.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（交際費)
      expect(find('#social-category')).to have_content(@budget1.social.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（特別費)
      expect(find('#special-category')).to have_content(@budget1.special.to_s(:delimited))
      # 予算ページには先ほど入力した内容が存在することを確認する（その他)
      expect(find('#variable-etcetera-category')).to have_content(@budget1.variable_etcetera.to_s(:delimited))
    end
  end
  context '予算の編集ができないとき' do
    it '誤った情報では予算の編集ができずに予算編集ページへ戻ってくる' do
      # 予算1を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @budget1.user.email
      fill_in 'password', with: @budget1.user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 予算ページへのリンクがあることを確認する
      expect(page).to have_link('予 算', href: budgets_path)
      # 予算ページに移動する
      visit budgets_path
      # 予算1の編集ページへのリンクがあることを確認する
      expect(page).to have_link('予算編集', href: edit_budget_path(@budget1))
      # 予算ページに移動する
      visit edit_budget_path(@budget1)
      # 入力フォームに誤った情報を入力する
      fill_in 'budget_house', with: ' '
      fill_in 'budget_communications', with: ' '
      fill_in 'budget_electricity', with: ' '
      fill_in 'budget_gas', with: ' '
      fill_in 'budget_water', with: ' '
      fill_in 'budget_education', with: ' '
      fill_in 'budget_premium', with: ' '
      fill_in 'budget_lawn', with: ' '
      fill_in 'budget_fixed_etcetera', with: ' '
      fill_in 'budget_food', with: ' '
      fill_in 'budget_commodity', with: ' '
      fill_in 'budget_transportation', with: ' '
      fill_in 'budget_hobby', with: ' '
      fill_in 'budget_clothes', with: ' '
      fill_in 'budget_health', with: ' '
      fill_in 'budget_culture', with: ' '
      fill_in 'budget_book', with: ' '
      fill_in 'budget_cafe', with: ' '
      fill_in 'budget_social', with: ' '
      fill_in 'budget_special', with: ' '
      fill_in 'budget_variable_etcetera', with: ' '
      # 送信してもBudgetモデルのカウントは上がらないことを確認する
      expect  do
        click_on('保 存')
      end.to change { Budget.count }.by(0)
      # 入力後、予算編集ページに留まることを確認する
      expect(current_path).to eq "/budgets/#{@budget1.id}"
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('入力ミス')
    end
    it 'ログインした予算１のユーザーは自分以外が登録した予算の編集ができない' do
      # 予算1を保存したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @budget1.user.email
      fill_in 'password', with: @budget1.user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 予算ページへのリンクがあることを確認する
      expect(page).to have_link('予 算', href: budgets_path)
      # 予算ページに移動する
      visit budgets_path
      # 予算ページに予算1の「予算編集」ボタンが存在することを確認する
      expect(page).to have_link('予算編集', href: edit_budget_path(@budget1))
      # 予算ページに予算2の「予算編集」ボタンが存在しないことを確認する
      expect(page).to have_no_link('予算編集', href: edit_budget_path(@budget2))
      # 予算2の編集ページのURLを直接入力しても遷移せずトップページに遷移することを確認する
      visit edit_budget_path(@budget2)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
    end
  end
end
