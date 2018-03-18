class User < ApplicationRecord
 has_secure_password

 has_one :cab, foreign_key: :name

 validates_presence_of :name, :email, :password_digest
end
