# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false, unique: true |
| password         | string | null: false |
| given_name       | string | null: false |
| family_name      | string | null: false |
| given_name_kana  | string | null: false |
| family_name_kana | string | null: false |
| birth_day        | date   | null: false |


### Association

- has_many :buy_histories
- has_many :goods


## goods テーブル

| Column               | Type   | Options     |
| -------------------- | ------ | ----------- |
| name                 | string    | null: false |
| description          | text      | null: false |
| category_id          | integer   | null: false |
| status_id            | integer   | null: false |
| price                | integer   | null: false |
| delivery_fee         | integer   | null: false |
| origin_prefecture_id | integer   | null: false |
| delivery_days_id     | integer   | null: false |
| fee_charger_id       | integer   | null: false |
| user                 | reference | null: false, foreign_key: true |


### Association

- belongs_to       :user
- has_one          :buy_history
- has_one_attached :image
<!-- - validates_associated :image, presence: true -->


## buy_histories テーブル

| Column  | Type      | Options     |
| ------- | --------- | ----------- |
| user    | reference | null: false, foreign_key: true |
| good    | reference | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :good
- has_ond :address


## addresses テーブル

| Column                | Type      | Options     |
| --------------------- | --------- | ----------- |
| postal_code           | string    | null: false |
| address_prefecture_id | integer   | null: false |
| address_municipality  | string    | null: false |
| address_house_number  | string    | null: false |
| address_building      | string    |             |
| tel_number            | string    | null: false |
| buy_history           | reference | null: false, foreign_key: true |


### Association

- belongs_to :buy_history
