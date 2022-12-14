class Address < ApplicationRecord
  belongs_to :customer

  validates :address, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
