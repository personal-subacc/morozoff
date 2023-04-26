class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :item_name, :description, :image, :non_taxed_price, presence: true

  def self.search(search)
    if search
      self.where(['item_name LIKE ?', "%#{search}%"])
    else
      self.all
      # 何も入力していない場合は全ての商品を表示
    end
  end
  # selfのところはItemモデルのことだからItem.seachやItem.where、Item.allでも可
  # 12、14行目はそれぞれwhere、allだけでもいける(self.要らない)
end