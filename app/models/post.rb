# Post
class Post < ApplicationRecord
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :ratings, dependent:  :destroy
  has_one_attached :image
end
