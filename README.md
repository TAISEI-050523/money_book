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

## incomes テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| category_id    | integer    | null: false                    |
| remarks        | text       |                                |
| price          | integer    | null: false                    |
| date_entered   | date       | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## fixed_costs テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| category_id    | integer    | null: false                    |
| remarks        | text       |                                |
| price          | integer    | null: false                    |
| date_entered   | date       | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## variable_costs テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| category_id    | integer    | null: false                    |
| remarks        | text       |                                |
| price          | integer    | null: false                    |
| date_entered   | date       | null: false                    |
| user           | references | null: false, foreign_key: true |

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
