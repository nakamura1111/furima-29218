class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,         presence: true
  # uniquenessについて、Rails6.1にする場合、読んで欲しい、https://qiita.com/jnchito/items/e23b1facc72bd86234b6
  validates :email,            presence: true, uniqueness: { case_sensitive: true }
  validates :password,         presence: true, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/ }  # UTF-8の全角文字の範囲調べる
  validates :given_name,       presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :family_name,      presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :given_name_kana,  presence: true, format: { with: /\A[ァ-ン]+\z/ }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ン]+\z/ }
  validates :birth_day,        presence: true

  has_many :goods
  has_many :buy_histories
end
