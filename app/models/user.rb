class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    # uniquenessについて、Rails6.1にする場合、読んで欲しい、https://qiita.com/jnchito/items/e23b1facc72bd86234b6
    validates :email,            uniqueness: { case_sensitive: true, allow_blank: true }
    validates :password,         format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/, allow_blank: true }
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, allow_blank: true } do
      validates :given_name
      validates :family_name
    end
    with_options format: { with: /\A[ァ-ン]+\z/, allow_blank: true } do
      validates :given_name_kana
      validates :family_name_kana
    end
    validates :birth_day
  end

  has_many :goods
  has_many :buy_histories
end
