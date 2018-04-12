class Picture < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
end
