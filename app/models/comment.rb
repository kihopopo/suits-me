class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :content, presence: true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

end
