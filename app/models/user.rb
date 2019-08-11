class User < ApplicationRecord
    has_secure_password
    has_many :comments
    has_many :rankings, through: :comments

end
