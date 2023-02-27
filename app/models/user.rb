class User < ApplicationRecord
  has_many :coaches
  
  validates :name, presence: true
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 }
  has_secure_password
end
