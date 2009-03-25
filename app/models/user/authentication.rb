class User < ActiveRecord::Base
  cattr_accessor :current

  attr_reader :password

  validates_presence_of     :password_hash, :password_salt
  validates_presence_of     :password, :on => :create
  validates_length_of       :password, :minimum => 5, :on => :create
  validates_confirmation_of :password, :on => :create

  def password=(cleartext)
    self.password_salt = Random.alphanumeric(10)
    self.password_hash = encrypt_password(cleartext)
    @password = cleartext
  end

  def encrypt_password(cleartext)
    Digest::SHA256.hexdigest("-_@--$-#{password_salt}-78-#{cleartext}--!")
  end

  def password_matches?(cleartext)
    password_hash == encrypt_password(cleartext)
  end

  def self.authenticate(login_or_email, password)
    if user = find_by_login(login_or_email) || find_by_email(login_or_email)
      return user if user.password_matches?(password)
    end
  end

  def current?
    User.current == self
  end
end