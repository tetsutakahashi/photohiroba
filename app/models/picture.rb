class Picture < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true
  validates :image, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  accepts_nested_attributes_for :favorites, allow_destroy: true

  has_many :photocmts, dependent: :destroy
  has_many :cmtusers, through: :photocmts, source: :users
  accepts_nested_attributes_for :photocmts, allow_destroy: true
end
