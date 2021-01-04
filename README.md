# 💰 ACCOUNT BOOK 💰
<img width="600" alt="qiita-square" src="https://github.com/TAISEI-050523/money_book/blob/master/top.png">

## 🌐 App URL
https://portfolio.taisei-account-book.com/  <br>【テストユーザーログイン】ボタンからテストユーザーとしてログインできます。 

# 📗 概 要

### 収入・固定費・変動費入力機能
　収入・固定費・変動費を項目ごと(給料、ボーナス、住居費、食費など２１項目)に登録しておくことができます。また過去１年間の収入・固定費・変動費の推移をチャートにて確認できます。
### 予算管理機能
　当月の予算を項目ごと（住居費、通信費、食費など２１項目）に登録しておくことで、当月使った固定費・変動費の各項目の金額と比較して、当月あといくら使えるのか、金額を表示することができます。
### 購入予定リスト機能
　欲しい物があるのに、なかなか上手く貯金ができない人向けの機能です。購入予定リストを登録することで、当日の貯金目安を管理することができます。例えば20日後に10,000円の商品を買いたいとしたら、1日に貯金すべき金額は1,000円となります。購入日、金額が異なる複数の商品を管理して、当日に必要な貯金額の目安を表示します。

#  🏙 制作背景(意図)
　お金が全てではないけど、何かを実現するためには最低限のお金が必要です。お金を普段から簡単に管理して、急な出費に備えたい。また欲しい物を計画的に買いたい。<br>　このアプリはお金を簡単に管理できるように「個人向けのシンプルな家計簿」として開発しました。同時に家計簿をつけるのは初めて、使い方が分からないということがないように、各機能ごとに説明が表示される【？】ボタンをつけるなどの工夫を施し、このアプリがきっかけでお金を管理する習慣ができるようなサービスを目指しました。
 
# ⚙️ 使用技術(開発環境)
### フロントエンド
- HTML/CSS
- JavaScript
### バックエンド
- Ruby : 2.6.5
- Rails : 6.0.3.4
### Webサーバー
- Nginx : 1.18.0 
### アプリケーションサーバー
- （開発環境）Puma : 3.12.1
- （本番環境）Unicorn : 5.4.1 
### データベース
- （開発環境）MySQL : 5.6.47
- （本番環境）MariaDB : 5.5.64 
### インフラ
- AWS (S3, VPC, EC2, Route53, Certificate Manager) 
- Capistrano : 3.14.1
### 解析ツール
- 静的コード解析（RuboCop）
### その他
- 非同期通信（Ajax）（収入・固定費・変動費入力機能）
- Git, GitHub
- Rspec(単体・結合テストコード)
- レスポンシブデザイン

# 📄 ER図
<img width="500" alt="qiita-square" src="https://github.com/TAISEI-050523/money_book/blob/master/app/assets/images/ER.png">

# 🖥　DEMO
## 収入・固定費・変動費入力機能
　収入・固定費・変動費を入力すると、トップページの過去１年間の推移に反映されます。
 <br><img width="400" alt="qiita-square" src="https://i.gyazo.com/32fa96ccca04e1390f14df8ecfb1f97c.gif">
### 予算管理機能
　予算を登録すると、固定費・変動費入力機能で入力したデータから当月あといくら使えるか計算します。
　<br><img width="400" alt="qiita-square" src="https://i.gyazo.com/01e94b853fa6932961a75a654e79d097.gif">
### 購入予定リスト機能
　購入予定リストを登録することで、購入日までの日数から１日に貯金すべき金額を計算します。
　<br><img width="400" alt="qiita-square" src="https://i.gyazo.com/c9f485fb0f9b601220607f31fa61e20d.gif">

# 🛠 工夫したポイント
- RSpecを用いたテストコードの実装を工夫しました。考えられるユーザーの操作をできる限り抽出して、正常系と異常系を分けて実装しました。
- 収入・固定費・変動費入力時、ブラウザが更新されることで、連続で入力する際にストレスを感じないように非同期通信を利用しました。
- 知人にアプリを実際に触ってもらい、フィードバックをもらうようにしました。各機能の使い方が分かりにくいという意見から【？】ボタンをつけて、各機能の詳細な使い方を表示しました。

# 🔧 課題や今後実装したい機能
- モデル・ビュー・コントローラーの可読性の向上させる。データベースとのやり取りはモデルに記載する。またヘルパーファイルやサービスクラスの活用する。

# 💽 テーブル設計
## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :incomes
- has_many :fixed_costs
- has_many :variable_costs
- has_many :purchase_plans
- has_one  :budgets

## incomes テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| income_category_id | integer    | null: false                    |
| remarks            | text       |                                |
| price              | integer    | null: false                    |
| income_date        | date       | null: false                    |
| user_id            | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## fixed_costs テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| fixed_cost_category_id | integer    | null: false                    |
| remarks                | text       |                                |
| price                  | integer    | null: false                    |
| expense_date           | date       | null: false                    |
| user_id                | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## variable_costs テーブル

| Column                     | Type       | Options                        |
| -------------------------- | ---------- | ------------------------------ |
| variable_costs_category_id | integer    | null: false                    |
| remarks                    | text       |                                |
| price                      | integer    | null: false                    |
| expense_date               | date       | null: false                    |
| user_id                    | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## purchase_plans テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| remarks        | text       |                                |
| price          | integer    | null: false                    |
| purchase_date  | date       | null: false                    |
| user_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## budgets テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| house             | integer    | null: false                    |
| communications    | integer    | null: false                    |
| electricity       | integer    | null: false                    |
| gas               | integer    | null: false                    |
| water             | integer    | null: false                    |
| education         | integer    | null: false                    |
| premium           | integer    | null: false                    |
| lawn              | integer    | null: false                    |
| fixed_etcetera    | integer    | null: false                    |
| food              | integer    | null: false                    |
| commodity         | integer    | null: false                    |
| transportation    | integer    | null: false                    |
| hobby             | integer    | null: false                    |
| clothes           | integer    | null: false                    |
| health            | integer    | null: false                    |
| culture           | integer    | null: false                    |
| book              | integer    | null: false                    |
| cafe              | integer    | null: false                    |
| social            | integer    | null: false                    |
| special           | integer    | null: false                    |
| variable_etcetera | integer    | null: false                    |
| user_id           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
