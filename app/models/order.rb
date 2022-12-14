class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  validates :postal_code, presence: true
  validates :name, presence: true
  validates :address, presence: true

  def shipping_cost
   800
  end

  def total
    total_payment-shipping_cost
  end

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, paid_up: 1, production: 2, preparing: 3, shipped: 4}

  def are_all_details_completed?
    (order_details.completed.count == order_details.count) ? true : false
  end

end

