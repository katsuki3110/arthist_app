class Sing < ApplicationRecord


  belongs_to :arthist
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  validates :link, presence: true

end
