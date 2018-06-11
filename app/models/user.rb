class User < ApplicationRecord
	#attr_accessor :remember_token

	before_save :add_remember_digest

	validates :name, presence: true, length: {minimum:6, maximum:50} 

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


	has_secure_password	
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

 	def User.new_token
    SecureRandom.urlsafe_base64.to_s
  end

  def User.digest(string)
  	Digest::SHA1.hexdigest(string)
  end

  private

 	def add_remember_digest
			self.remember_digest = User.digest(User.new_token)
	end
end
