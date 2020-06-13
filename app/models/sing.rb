class Sing < ApplicationRecord

  belongs_to :user

  validates :name, presence: true, length: {maximum: 50}
  validates :link, presence: true

end
