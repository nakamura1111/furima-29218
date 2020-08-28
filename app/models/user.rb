class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,         presence: true
  validates :email,            presence: true, uniqueness: true
  validates :password,         presence: true, length: {minimum: 6}
  validates :given_name,       presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :family_name,      presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :given_name_kana,  presence: true, format: {with: /\A[ァ-ン]+\z/ }
  validates :family_name_kana, presence: true, format: {with: /\A[ァ-ン]+\z/ }
  validates :birth_day,        presence: true
end
