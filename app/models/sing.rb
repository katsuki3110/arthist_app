class Sing < ApplicationRecord


  belongs_to :arthist
  has_many :likes, dependent: :destroy
  has_many :like_sings, through: :likes, foreign_key: :sing_id

  validates :link, presence: true

end
