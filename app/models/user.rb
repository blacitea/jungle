class User < ActiveRecord::Base

  def self.authenticate_with_credentials(email, password)
    if User.find_by_email(email.strip.downcase)
      @user = User.find_by_email(email.strip.downcase).authenticate(password)
    else
      false
    end
  end

  has_secure_password

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 5, too_short:"minimum %{count} characters required."}

  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end

end
