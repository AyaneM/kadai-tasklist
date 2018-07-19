
class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :tasks
  has_many :favorites
  has_many :like_tasks, through: :likes, class_name: 'Task', source: :task
  
 def like(task)
      self.favorites.find_or_create_by(task_id: task.id)
  
  end

  def unlike(task)
    like = self.likes.find_by(task_id: task.id)
    like.destroy if like
  end

  def like?(task)
    self.like_tasks.include?(task)
  end


end