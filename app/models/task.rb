class Task < ApplicationRecord
 belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites
  has_many :users, through: :favorites
  has_many :likes
  has_many :like_users, through: :likes, class_name: 'User', source: :user
  end
