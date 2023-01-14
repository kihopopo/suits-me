class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :customer

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true


  def get_image(width, height)
   unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
  image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
