# 💰 ACCOUNT BOOK 
## 🌐 App URL
https://portfolio.taisei-account-book.com/

# 📗 概 要

### 収入・固定費・変動費入力機能
　収入・固定費・変動費を項目(給料、ボーナス、住居費、食費など)ごとに登録しておくことができます。また過去１年間の推移をチャートにて確認できます。
### 予算管理機能
　当月の予算を項目（住居費、通信費、食費など２１項目）ごとに登録しておくことで、当月使った固定費・変動費の各項目の金額と比較して、当月あといくら使えるのか、表示することができます。
### 購入予定リスト機能
　欲しい物があるのに、なかなか上手く貯金ができない人向けの機能です。購入予定リストを登録することで、当日の貯金目安を管理することができます。例えば20日後に10,000円の商品を買いたいとしたら、1日に貯金すべき金額は1,000円となります。購入日、金額が異なる複数の商品を管理して、当日に必要な貯金額の目安を表示します。

# 🌇 制作背景(意図)
　お金が全てではないけど、何かを実現するためには最低限のお金が必要です。そのためにも、普段から自身のお金を管理する習慣を身に付ける必要があります。  このアプリはお金を簡単に管理できるように「個人向けの家計簿」として開発しました。その日、得たお金や使ったお金を記録することで、簡単に自身のお金を管理できるように作っています。また身近な自己実現である「欲しい物を買う」という目標に役立つ購入予定リスト機能もつけました。

# ER図
<img width="500" alt="qiita-square" src="https://github.com/TAISEI-050523/money_book/blob/master/app/assets/images/ER.png">

# 本番環境(デプロイ先 テストアカウント＆ID)
## Basic認証のIDとパスワード
- ID：　ktm895  
- パスワード：89890523
## テストアカウントのメールアドレスとパスワード
- メールアドレス: kkk@kkk.com  
- パスワード　 : 123kkk

# DEMO
　(gifで動画や写真を貼って、ビューのイメージを掴んでもらいます)
　⇒特に、デプロイがまだできていない場合は
　DEMOをつけることで見た目や昨日の操作方法を企業側に伝えることができます。

# 使用技術(開発環境)
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
- AWS (EC2, S3, VPC, Route53, ALB, ACM) 
- Git, GitHub
- Capistrano : 3.14.1
### 解析ツール
- 静的コード解析（RuboCop）

# 工夫したポイント


# 課題や今後実装したい機能
ビデオの添付機能（課題解決改善のために、ビデオを添付するチャット機能を作成する
部屋のランクによって、電話機能やビデオ通話機能を搭載する
### UIの向上
- 基本的な動作は全て非同期化する


# テーブル設計
## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :income
- has_many :fixed_cost
- has_many :variable_cost
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
| user           | references | null: false, foreign_key: true |

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
