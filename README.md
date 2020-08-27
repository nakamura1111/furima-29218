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
| email            | string | null: false, inclusion: {in: %@%}, uniqueness: true  |
| password         | string | null: false, length: {minimum: 6}                    |
| given_name       | string | null: false, format: {with: /\A[ぁ-んァ-ン一-龥]+\z/}  |
| family_name      | string | null: false, format: {with: /\A[ぁ-んァ-ン一-龥]+\z/}  |
| given_name_kana  | string | null: false, format: {with: /\A[ァ-ン]+\z/}           |
| family_name_kana | string | null: false, format: {with: /\A[ァ-ン]+\z/}           |
| birth_day        | date   | null: false |


### Association

- has_many :buyers
- has_many :goods


## goods テーブル

| Column               | Type   | Options     |
| -------------------- | ------ | ----------- |
| name                 | string    | null: false |
| description          | text      | null: false |
| category_id          | integer   | null: false |
| status_id            | integer   | null: false |
| price                | integer   | null: false, {greater_than_or_equal_to: 300, greater_than_or_equal_to: 9,999,999}  |
| delivery_fee         | integer   | null: false |
| origin_prefecture_id | integer   | null: false |
| delivery_days_id     | integer   | null: false |
| fee_charger_id       | integer   | null: false |
| user                 | reference | null: false, foreign_key: true |


### Association

- belongs_to       :user
- has_one          :bayer
- has_one_attached :image
- validates_associated :image, presence: true


## buyers テーブル

| Column                | Type      | Options     |
| --------------------- | --------- | ----------- |
| postal_code           | string    | null: false, format: {with: /\A\d{3}[-]\d{3}\z/} |
| address_prefecture_id | integer   | null: false |
| address_municipality  | string    | null: false |
| address_house_number  | string    | null: false |
| address_building      | string    |             |
| tel_number            | string    | null: false, length: {maximum: 11} |
| user                  | reference | null: false, foreign_key: true |
| good                  | reference | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :good
