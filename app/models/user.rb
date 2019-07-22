class User < ApplicationRecord
  has_secure_password

  has_many :ideas, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
