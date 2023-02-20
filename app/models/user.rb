

class User < ActiveRecord::Base

  has_secure_password

  def self.authenticate_with_credentials(email, password)

    @email = email.strip
    @downcase_email = @email.downcase
    @user = User.find_by_email(@downcase_email)

    if BCrypt::Password.new(@user.password_digest) == password 
      return @user
    else
      return nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end

end