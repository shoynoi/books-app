class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  validates :title, presence: true, length: { maximum: 30 }
  validates :memo, presence: true
  paginates_per 10
end
