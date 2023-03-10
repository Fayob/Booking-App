class Coach < ApplicationRecord
  belongs_to :user
  has_many :reserves, class_name: 'Reserve', dependent: :delete_all

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
