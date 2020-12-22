require 'rails_helper'

RSpec.describe '購入予定リスト追加', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @purchase_plan = FactoryBot.create(:purchase_plan)
    # 添付する画像を定義する
    @image_path = Rails.root.join('public/images/test_image.png')            # テスト用商品画像
    @purchase_plan_name = @purchase_plan.name                                # 商品名
    @purchase_plan_remarks = @purchase_plan.remarks                          # 備考
    @purchase_plan_price = @purchase_plan.price                              # 値段
    # date_fieldに入力するため変換(例：2020-01-01 ➜ 002020-01-01)
    @purchase_plan_purchase_date = "00#{@purchase_plan.purchase_date.year}-#{@purchase_plan.purchase_date.mon}-#{@purchase_plan.purchase_date.day}" # 購入日
  end
  context '購入予定リストの追加ができるとき' do
    it 'ログインしたユーザーは購入予定リストページで購入予定リストの追加ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 購入予定リストページへのリンクがあることを確認する
      expect(page).to have_link('購入予定リスト', href: purchase_plans_path)
      # 購入予定リストページに移動する
      visit purchase_plans_path
      # 入力フォームに情報を入力する
      attach_file('purchase_plan[image]', @image_path, make_visible: true)
      fill_in 'purchase_plan_name', with: @purchase_plan_name
      fill_in 'purchase_plan_remarks', with: @purchase_plan_remarks
      fill_in 'purchase_plan_price', with: @purchase_plan_price
      fill_in 'purchase_plan_purchase_date', with: @purchase_plan_purchase_date
      # 送信するとPurchasePlanモデルのカウントが1上がることを確認する
      expect  do
        click_on('保 存')
      end.to change { PurchasePlan.count }.by(1)
      # 入力後、購入予定リストページに留まることを確認する
      expect(current_path).to eq purchase_plans_path
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在することを確認する（商品画像）
      expect(find('#purchase_item_box')).to have_selector('img')
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在することを確認する（商品名）
      expect(find('#purchase_item_box')).to have_content(@purchase_plan_name)
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在することを確認する（備考）
      expect(find('#purchase_item_box')).to have_content(@purchase_plan_remarks)
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在することを確認する（値段）
      expect(find('#purchase_item_box')).to have_content(@purchase_plan_price.to_s(:delimited))
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在することを確認する（購入日）
      expect(find('#purchase_item_box')).to have_content(@purchase_plan_date)
    end
  end
  context '購入予定リストが追加できないとき' do
    it 'ログインしていないと購入予定リストページに遷移できない' do
      # 購入予定リストページに遷移する
      visit purchase_plans_path
      # ログインページにリダイレクトされる
      expect(current_path).to eq new_user_session_path
    end
    it '誤った情報では購入予定リストの追加ができずに購入予定リストページへ戻ってくる' do
      # ログインする
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 購入予定リストページへのリンクがあることを確認する
      expect(page).to have_link('購入予定リスト', href: purchase_plans_path)
      # 購入予定リストページに移動する
      visit purchase_plans_path
      # 入力フォームに誤った情報を入力する
      fill_in 'purchase_plan_name', with: ''
      fill_in 'purchase_plan_remarks', with: ''
      fill_in 'purchase_plan_price', with: ''
      fill_in 'purchase_plan_purchase_date', with: ''
      # 送信してもPurchasePlanモデルのカウントは上がらないことを確認する
      expect  do
        click_on('保 存')
      end.to change { PurchasePlan.count }.by(0)
      # 入力後、購入予定リストページに留まることを確認する
      expect(current_path).to eq purchase_plans_path
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content('入力ミス')
    end
  end
end

RSpec.describe '購入予定リスト削除', type: :system do
  before do
    @purchase_plan1 = FactoryBot.create(:purchase_plan)       # 購入予定リスト１
    @purchase_plan2 = FactoryBot.create(:purchase_plan)       # 購入予定リスト２
  end
  context '購入予定リストを削除ができるとき' do
    it 'ログインしたユーザーは自らが保存した購入予定リストを削除ができる' do
      # 購入予定リスト1を保存したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @purchase_plan1.user.email
      fill_in 'password', with: @purchase_plan1.user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 購入予定リストページへのリンクがあることを確認する
      expect(page).to have_link('購入予定リスト', href: purchase_plans_path)
      # 購入予定リストページに移動する
      visit purchase_plans_path
      # 購入予定リスト詳細欄 購入予定リスト1に「削除」ボタンがあることを確認する
      expect(find('#purchase_item_box')).to have_content('削除')
      # 保存を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: purchase_plan_path(@purchase_plan1)).click
      end.to change { PurchasePlan.count }.by(-1)
      # 削除後、購入予定リストページに留まることを確認する
      expect(current_path).to eq purchase_plans_path
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在しないを確認する（商品画像）
      expect(find('#purchase_item_box')).to have_no_selector('img')
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在しないを確認する（商品名）
      expect(find('#purchase_item_box')).to have_no_content(@purchase_plan1.name)
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在しないを確認する（備考）
      expect(find('#purchase_item_box')).to have_no_content(@purchase_plan1.remarks)
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在しないを確認する（値段）
      expect(find('#purchase_item_box')).to have_no_content(@purchase_plan1.price.to_s(:delimited))
      # 購入予定リストページには先ほど入力した内容が購入予定リストに存在しないを確認する（購入日）
      expect(find('#purchase_item_box')).to have_no_content(@purchase_plan1.purchase_date)
    end
  end
  context '購入予定リスト削除ができないとき' do
    it 'ログインしたユーザーは自分以外が保存した購入予定リストの削除ができない' do
      # 購入予定リスト1を保存したユーザーでログインする
      visit new_user_session_path
      fill_in 'email', with: @purchase_plan1.user.email
      fill_in 'password', with: @purchase_plan1.user.password
      find('input[id="submit-btn"]').click
      expect(current_path).to eq root_path
      # 購入予定リストページへのリンクがあることを確認する
      expect(page).to have_link('購入予定リスト', href: purchase_plans_path)
      # 購入予定リストページに移動する
      visit purchase_plans_path
      # 購入予定リスト詳細欄 購入予定リスト1の「削除」ボタンがあることを確認する
      expect(find('#purchase_item_box')).to have_link '削除', href: purchase_plan_path(@purchase_plan1)
      # 購入予定リスト詳細欄 購入予定リスト2の「削除」ボタンがないことを確認する
      expect(find('#purchase_item_box')).to have_no_link '削除', href: purchase_plan_path(@purchase_plan2)
    end
  end
end
