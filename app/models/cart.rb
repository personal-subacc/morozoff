class Cart < ApplicationRecord
  belongs_to :end_user
  belongs_to :item
end