class Tag < ApplicationRecord
  has_many :item_tags
  has_many :items, through: :item_tags

  def self.search(word, method)
    # TODO: 最終実行結果が戻り値になるので変数に入れなくても良い
    # TODO: CASEに関する補足 : https://www.javadrive.jp/ruby/if/index9.html
    case method
    when 'perfect_match' then # 完全一致
      Tag.where("name LIKE ?", "#{word}")
    when 'partial_match' then # 部分一致
      Tag.where("name LIKE ?", "%#{word}%")
    else # 何も一致処理がなかった場合の保険
      Tag.all
    end
  end
end
