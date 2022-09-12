class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  
  enum is_active: {"販売中": true,"販売停止中": false}
    
  def add_tax_price
    (self.price*1.10).round
  end
    
  def with_tax_price
    (price * 1.1).floor
  end
    
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
