class User < ApplicationRecord
	has_many :posts

	before_create :create_remember_token

	validates :name, presence: true, length: {minimum:6, maximum:50} 

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


	has_secure_password	
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

 	def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  private

 	def create_remember_token
			self.remember_token = User.encrypt(User.new_token)
	end
end
