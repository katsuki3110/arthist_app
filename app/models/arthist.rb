class Arthist < ApplicationRecord

  belongs_to :user
  has_many :sings, dependent: :destroy

  validates :name, presence: true, length: {maximum: 30}

  accepts_nested_attributes_for :sings

end
