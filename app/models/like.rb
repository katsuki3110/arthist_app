class Like < ApplicationRecord

  belongs_to :user
  belongs_to :sing

  validates :user_id, presence: true
  validates :sing_id, presence: true

end
