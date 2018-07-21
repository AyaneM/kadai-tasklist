class Task < ApplicationRecord
 belongs_to :user

  validates :user_id, presence: true
  validates :status, :content, presence: true, length: { maximum: 255 }
  
  end
