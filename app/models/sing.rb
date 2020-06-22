class Sing < ApplicationRecord


  belongs_to :arthist
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  validates :name, presence: true, length: {maximum: 50}
  validates :link, presence: true

end
