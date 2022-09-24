class Customer < ApplicationRecord

 has_many :addresses
 has_many :cart_items
 has_many :orders
 has_many :post_images, dependent: :destroy
 has_many :post_images, dependent: :destroy
 has_many :post_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 def full_name
  self.first_name + " " + self.last_name
 end

 def full_name_kana
  self.first_name_kana + " " + self.last_name_kana
 end

  has_one_attached :profile_image

  def get_profile_image(width, height)
   unless profile_image.attached?
       file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
     profile_image.variant(resize_to_limit: [width, height]).processed
  end

end



