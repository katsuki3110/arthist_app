class User < ApplicationRecord

  attr_accessor :remember_token


  validates :name,  presence: true, length: {maximum: 30}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 8}

  before_save :downcase_email

  #パスワードのハッシュ化
  def User.digest(password)
    BCrypt::Password.create(password)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end


  private

  def downcase_email
    self.email = email.downcase
  end

end
