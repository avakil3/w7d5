class User < ApplicationRecord

	validates :username, presence: true, uniqueness:true
	validates :session_token, presence: true, uniqueness:true
	validates :password_digest, presence: true
	validates :password, length: {minimum: 6, allow_nil: true}

	attr_reader :password
	after_initialize :ensure_session_token

    has_many :subs,
        # primary_id: :id,
        foreign_key: :user_id,
        class_name: :Sub

	has_many :posts,
		# primary_id: :id,
		foreign_key: :user_id,
		class_name: :Post

	def self.find_by_credentials(username,password)
		user = User.find_by(username: username)
		return nil if user.nil?
		return user if user.is_password?(password)
	end

	def is_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def password=(password)
		@password=password
		self.password_digest= BCrypt::Password.create(password)
	end

	
	def reset_session_token!
		self.session_token= SecureRandom.base64(16)
		self.save!
		self.session_token
	end

	private
	def ensure_session_token
		self.session_token ||= SecureRandom.base64(16)
	end


end
