class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :item_id, uniqueness: { scope: :customer_id }
  validates :amount, numericality: {
    less_than_or_equal_to: 10,
    greater_than_or_equal_to: 1}, presence: true

  def subtotal
    item.add_tax_price * amount
  end
end
