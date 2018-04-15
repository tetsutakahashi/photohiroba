class Picture < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :users, through: :favorites

  has_many :photocmts
  has_many :cmtusers, through: :photocmts, source: :users
end
