class Idea < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, uniqueness: true

  belongs_to :user
  has_many :reviews, dependent: :destroy
end
