class Item < ApplicationRecord
  has_one_attached :image
  #belongs_to :genre
  has_many :cart_items
  has_many :item_tags
  has_many :tags, through: :item_tags
  has_many :order_details
  has_many :comments, dependent: :destroy



  def add_tax_price
    (self.price*1.10).round
  end

  def with_tax_price
    (price * 1.1).ceil
    # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # 商品検索
  #   wordは[検索ワード] / methodは[検索手法]
  def self.search(word, method)
    # TODO: 最終実行結果が戻り値になるので変数に入れなくても良い
    # TODO: CASEに関する補足 : https://www.javadrive.jp/ruby/if/index9.html
    case method
    when 'perfect_match' then # 完全一致
      Item.where("name LIKE ? OR introduction LIKE ?", "#{word}", "#{word}")
    when 'partial_match' then # 部分一致
      Item.where("name LIKE ? OR introduction LIKE ?", "%#{word}%", "%#{word}%")
    else # 何も一致処理がなかった場合の保険
      Item.all
    end
  end
end
