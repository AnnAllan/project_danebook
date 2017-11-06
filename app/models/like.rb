class Like < ApplicationRecord
  belongs_to :likable, :polymorphic => true
  belongs_to :user

  validates :user_id, uniqueness: {scope:[:likable_id, :likable_type]}
  validates :likable_id, :likable_type, presence: true

  def self.recent_likes
    order("created_at DESC").limit(4)
  end

  def self.recent_users_like
    recent_likes.first.user if self.like_count > 0
  end

  def self.like_count
    count
  end

  def self.you_liked?(current_user)
    where("user_id = ?", current_user.id).any?
  end

  def like_list(likable_id, likable_type)
    where("likable_id = ? AND likable_type = ?", likable_id, likable_type)
  end
end
