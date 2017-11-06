class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, :as => :likable, class_name: "Like", dependent: :destroy
  has_many :comments, :as => :commentable, class_name: "Comment", dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true

end
