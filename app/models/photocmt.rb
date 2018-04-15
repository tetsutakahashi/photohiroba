class Photocmt < ApplicationRecord
  belongs_to :user
  belongs_to :picture
  
  validates :user_id, presence: true
  validates :picture_id, presence: true
  validates :comment, presence: true, length: { maximum: 255 }
 
end
