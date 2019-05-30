class Report < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  has_many :comments, as: :commentable
end
