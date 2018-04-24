class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  has_many :relationships, dependent: :destroy
  accepts_nested_attributes_for :relationships, allow_destroy: true
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  has_many :favorites, dependent: :destroy
  has_many :favopictures, through: :favorites, source: :picture
  accepts_nested_attributes_for :favorites, allow_destroy: true
  
  def favort(fv_picture)
    unless self == fv_picture.user
      self.favorites.find_or_create_by(picture_id: fv_picture.id)
    end
  end

  def unfavort(fv_picture)
    favorite = self.favorites.find_by(picture_id: fv_picture.id)
    favorite.destroy if favorite
  end

  def favopicture?(fv_picture)
    self.favopictures.include?(fv_picture)
  end

  has_many :photocmts, dependent: :destroy
  has_many :cmtpictures, through: :photocmts, source: :picture
  accepts_nested_attributes_for :photocmts, allow_destroy: true

  def phcomment(fv_picture,cmt)
    self.photocmts.find_or_create_by(picture_id: fv_picture.id,comment: cmt)
  end

  def unphcomment(fv_picture,cmt)
    photocmt = self.photocmts.find_by(picture_id: fv_picture.id,comment: cmt)
    photocmt.destroy if photocmt
  end
end
