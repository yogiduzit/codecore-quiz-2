class Idea < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, uniqueness: true


  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :likers, through: :likes, source: :user
end
