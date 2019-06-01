class Comment < ApplicationRecord
  validates :description, presence: true
  belongs_to :commentable, polymorphic: true
end
