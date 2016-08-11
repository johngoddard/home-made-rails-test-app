require_relative '../../lib/active_record_lite/sql_object'
require 'securerandom'
require 'bcrypt'

class User < SQLObject
  attr_reader :password

  has_many :cats, foreign_key: :owner_id
  has_many :cat_rental_requests

  self.table_name = 'users'
  self.finalize!

  def self.find_by_credentials(creds)
    user = User.where(username: creds[:username]).first
    return nil unless user && user.is_password?(creds[:password])
    user
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    self.session_token
  end
end
