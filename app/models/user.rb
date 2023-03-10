class User < ApplicationRecord
  before_save { self.username = username.downcase }

  has_many :coaches, dependent: :delete_all
  has_many :reserves, class_name: :Reserve, dependent: :delete_all

  validates :name, presence: true
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 }
  has_secure_password
end
