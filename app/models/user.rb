require 'digest'

class User < ApplicationRecord
    has_one :wallet, dependent: :destroy
    
    attr_accessor :password

    before_save :hash_password

    def self.authenticate(email, password)
        user = find_by(email: email)
        return nil unless user

        hashed_password = Digest::SHA256.hexdigest(user.password_salt + password)
        return user if user.password_hash == hashed_password

        nil
    end

    private

    def hash_password
        if password.present?
            self.password_salt = SecureRandom.base64(8)
            self.password_hash = Digest::SHA256.hexdigest(password_salt + password)
        end
    end
end
