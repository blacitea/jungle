class User < ActiveRecord::Base

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email).authenticate(password)
  end

  has_secure_password

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 5, too_short:"minimum %{count} characters required."}


end
