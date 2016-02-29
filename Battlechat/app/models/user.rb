class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40}
                       
  before_create {generate_token(:auth_token)}

  def generate_token(column)
    begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
  end
end
