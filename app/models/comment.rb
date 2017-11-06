class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, :as => :likable, class_name: "Like", dependent: :destroy

  validates :commentable_id, :commentable_type, :content, :user_id,
            presence: true
  validates :content, length: {in: 1..1000}
end
