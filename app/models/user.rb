class User < ApplicationRecord
    has_secure_password
    validates :email, format: { with: URI::MailTo::EMAIL:REGEXP }
    validates :password,
        length { minimum: 8 },
        if: -> { new_record? || !password.nil? }
end
