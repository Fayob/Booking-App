class Reserve < ApplicationRecord
  belongs_to :user
  belongs_to :coach

  validates :city, presence: true
  validates :date, presence: true, comparison: { greater_than_or_equal_to: Date.today }
end
