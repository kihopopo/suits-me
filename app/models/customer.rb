class Customer < ApplicationRecord

 has_many :addresses
 has_many :cart_items
 has_many :orders
 has_many :post_images, dependent: :destroy
 has_many :post_images, dependent: :destroy
 has_many :post_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 validates :first_name, presence:true
 validates :last_name, presence:true
 validates :first_name_kana, presence:true
 validates :last_name_kana, presence:true
 validates :username, presence:true, length: { maximum: 20 }
 validates :postal_code, presence:true
 validates :address, presence:true
 validates :telephone_number, presence:true
 validates :first_name, presence:true

 def full_name
  self.first_name + " " + self.last_name
 end

 def full_name_kana
  self.first_name_kana + " " + self.last_name_kana
 end

  has_one_attached :profile_image

  def get_profile_image(width, height)
   unless profile_image.attached?
       file_path = Rails.root.join('app/assets/images/no_image.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
     profile_image.variant(resize_to_limit: [width, height]).processed
  end

end



