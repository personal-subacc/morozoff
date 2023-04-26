class OrderDetail < ApplicationRecord
  enum making_status: { 着手不可: 0, 製造待ち: 1, 製造中: 2, 製造完了: 3 }

  belongs_to :order
  belongs_to :item
end