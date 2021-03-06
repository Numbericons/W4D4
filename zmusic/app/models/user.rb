# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :password_digest, presence: true
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 5, allow_nil: true }

    attr_reader :password

    after_initialize :ensure_session_token

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)

        user && user.is_password?(password) ? user : nil
    end

    # def self.set_activation_token
    #     self.activation_token = generate_unique_activation_token
    # end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

     def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token! 
        self.session_token ||= generate_unique_session_token
        self.save!
        self.session_token
    end

    def generate_unique_session_token
        SecureRandom.urlsafe_base64(16)
        #token = 
        # while self.class.exists?(session_token: token)
        #     token = SecureRandom.urlsafe_base64(16)
        # end

        # token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end
end
