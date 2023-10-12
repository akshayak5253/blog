class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :topics
  has_many :posts
  has_many :comments
  has_many :ratings
  has_many :posts_users_read_statuses
  has_many :read_posts, -> { where("posts_users_read_statuses.read": true) }, through: :posts_users_read_statuses, source: :post, class_name: "Post"
  has_many :unread_posts, -> { where("posts_users_read_statuses.read": false) }, through: :posts_users_read_statuses, source: :post, class_name: "Post"
  has_many :user_comment_ratings
  has_many :comments, through: :user_comment_ratings
  def rating_for_comment(comment)
    comment_ratings.where(comment: comment).first.try(:rating)
  end
end
