class User < ApplicationRecord

  validates :name,  presence: true, length: {maximum: 30}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 8}

  before_save :downcase_email


  private

  def downcase_email
    self.email = email.downcase
  end

end
