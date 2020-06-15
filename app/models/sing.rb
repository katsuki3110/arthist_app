class Sing < ApplicationRecord

  belongs_to :arthist

  validates :link, presence: true

end
