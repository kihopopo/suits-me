class Order < ApplicationRecord
  belongs_to :customer

  def shipping_cost
  800
  end

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

end

