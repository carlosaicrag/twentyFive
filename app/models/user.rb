class User < ApplicationRecord
  validates :username,:email, presence:true
  validates :password, length: {minimum: 6}, allow_nil: true
  # S.P.I.R.E
  #S self.find_by_credentials
  #P password= 
  #I is_password?
  #R reset_session_token!
  #E ensure_session_token
  attr_reader :password
  after_initialize :ensure_session_token

  def self.find_by_credentials(username,pw)
    user = User.find_by(username: username)

    if user && user.is_password?(pw)
      user
    else
      nil
    end
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)

    @password = password
  end

  def is_password?(password) 
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

end
